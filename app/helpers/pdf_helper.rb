# encoding: utf-8
module PdfHelper
  
  def font_light()  "#{Rails.root}/public/fonts/helvetica_neue_light.ttf"  end
  def font_bold()   "#{Rails.root}/public/fonts/helvetica_neue_bold.ttf" end
  
  def dark_line()   "CCCCCC"  end
  def bright_line() "FFFFFF"  end
  
  def small_header(pdf, options)
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 1.5.cm], :width  => pdf.bounds.width, :height => 12.mm do
      pdf.font font_bold
      
      pdf.text options[:document_description]
      pdf.text_box options[:address].name, :at => [5.5.cm, pdf.bounds.top]

      pdf.font font_light
      pdf.text_box options[:address].location_s(", "), :at => [5.5.cm, pdf.bounds.top - 10.pt]
      pdf.font font_bold
      
      pdf.text_box options[:date].to_s, :at => [12.cm, pdf.bounds.top], :align => :right
      
#      pdf.font font_light
#      pdf.text_box @order.terms.name, :at => [12.cm, pdf.bounds.top - 10.pt], :align => :right
#      pdf.font font_bold
      
      pdf.move_down 10.pt
      pdf.line_width = 0.1.pt
      pdf.stroke_horizontal_rule
      pdf.line_width = 1.pt
    end
  end
  
  def first_page_header(pdf, options)
    #header picture
    place_header(pdf, options[:client_id])
    
    #address
    pdf.move_cursor_to(pdf.bounds.top - 50.mm) #66m from top
    pdf.font font_bold
    pdf.text_box options[:address].name, :at => [pdf.bounds.left, pdf.cursor]
    
    pdf.font font_light
    pdf.text_box options[:address].location_s, :at => [pdf.bounds.left, pdf.cursor - 10.pt]
    
    print_barcode(pdf, options[:barcode]) unless options[:barcode].blank?
  end
  
  def place_header(pdf, client_id)
    pdf.image "#{Rails.root}/public/images/headers/client_#{client_id}_default.png",:vposition => :top,
    :position => -25.mm,
    :width => 210.mm
  end

  def place_comment(pdf, comment)
    pdf.move_down 10.pt
    c = pdf.cursor
    pdf.text "Kommentar:"
    pdf.font font_light
    pdf.text_box comment.to_s, :at => [2.cm, c], :width => 12.cm
    pdf.move_down 10.pt
  end
  
  def footer(pdf)
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 28.cm], :width  => pdf.bounds.width do
      pdf.font font_light
      pdf.text pdf.page_number.to_s, :align => :center
    end
  end
  
  def footer_with_page_numbering(pdf)
    f = -> {footer(pdf)}
    pdf.repeat :all, :dynamic => true do
      f.call
    end
  end
  
  def print_barcode(pdf, barcode)
    pdf.move_down(16.pt)
    #barcode
    barcode = Barby::Code128.new(barcode, "A")
    barcode.annotate_pdf pdf, :x => pdf.bounds.left + 120.mm, :y => pdf.cursor, :height => 0.6.cm, :xdim => 0.30.mm
    pdf.font font_bold
    pdf.text_box barcode.to_s, :at => [pdf.bounds.left + 120.mm, pdf.cursor], :width => 45.mm, :align => :center
    pdf.font font_light

    #QrCode
    #barcode = Barby::QrCode.new(polymorphic_url(@order))
    #barcode.annotate_pdf pdf, :x => pdf.bounds.left + 120.mm, :y => pdf.cursor, :xdim => 0.8.mm
    
  end
  
  def new_page(pdf)
    footer(pdf)
    pdf.start_new_page
    pdf.move_cursor_to(pdf.bounds.top - 30.mm) #from top
  end
  
  def style_receipt_table(pdf, style, items)
    
    table = []
    total_q = 0
    total_p = Money.new(@currency)
    
    style.colours.sort_by(&:rank).each do |colour|
      row = [colour.to_s]
      empty = true
      colour_q = 0
      colour_p = Money.new(@currency)
      
      style.sizes.sort_by(&:rank).each do |size|
        i = items.find {|i| i.article.colour_id == colour.id && i.article.size_id == size.id}
        
        q = i.nil? ? "" : i.quantity.to_s
        colour_q += q.to_i
        colour_p += i.total_price unless i.nil?
        empty = false unless q.blank?
        
        row << "#{size.to_s.split.first}: #{q}"
        
      end
      
     unless empty
        #the design is made for max 7 colours. if there are more, split over several lines
        if 7 < row.size
          colour_name = row.shift
          sub_rows = row.each_slice(7).to_a
          
          #first row contains colour name
          table << sub_rows.shift.insert(0, colour_name).insert(-1, "").insert(-1, "")
          
          sub_rows.each do |r| 
            row = r.insert(0, "").insert(-1, "").insert(-1, "")
            table << row
          end
          table.last[8] = colour_q.to_s
          table.last[9] = colour_p.to_s
        else
          row[8] = colour_q.to_s
          row[9] = colour_p.to_s
          table << row
        end
        
        total_q += colour_q
        total_p += colour_p
      end
    end
    
    #start on new page for this style?
    style_height = 20.mm #header and spacing down
    style_height += table.size * 6.mm #each row needs 6mm
    if pdf.cursor < style_height
      footer(pdf)
      pdf.start_new_page
      pdf.move_cursor_to(pdf.bounds.top - 35.mm) #from top
    end
    
    #style header
    pdf.font font_bold
    cursor = pdf.cursor
    pdf.text style.to_s
    
    pdf.font font_light
    pdf.text_box "#{style.form}", :at => [41.mm, cursor], :align => :left
    pdf.text_box "EP #{style.wholesale_price(@currency)}", :at => [56.mm, cursor], :align => :left
    pdf.text_box "VP #{style.retail_price(@currency)}", :at => [86.mm, cursor], :align => :left
    pdf.text_box "Anzahl", :at => [13.cm, cursor]
    
    #we can assume the table is not empty since the styles are derived from the line_items
    table_colours = [dark_line,bright_line]
    pdf.table table,
      :row_colors => table_colours,
      :font_size => 8.8.pt,
      :border_width => 0,
      :position => pdf.bounds.left,
      :column_widths => {0 => 25.mm, 1 => 15.mm, 2 => 15.mm, 3 => 15.mm, 4 => 15.mm, 5 => 15.mm, 6 => 15.mm,
        7 => 15.mm, 8 => 10.mm, 9 => 25.mm},
      :vertical_padding => 1.mm,
      :horizontal_padding => 1.mm,
      :align => {0 => :left, 1 => :left, 2 => :left, 3 => :left, 4 => :left, 5 => :left, 6 => :left,
        7 => :left, 8 => :right, 9 => :right}
    
    pdf.font font_bold
    pdf.table [["Total #{style}", total_q.to_s, total_p.to_s]],
      :font_size => 8.8.pt,
      :border_width => 0,
      :position => pdf.bounds.left,
      :column_widths => {0 => 130.mm, 1 => 10.mm, 2 => 25.mm},
      :vertical_padding => 1.mm,
      :horizontal_padding => 1.mm,
      :align => {0 => :left, 1 => :right, 2 => :right}
      
    pdf.move_down 10.mm
  end
end