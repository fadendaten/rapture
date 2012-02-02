#encoding: utf-8
require "prawn/measurement_extensions"


prawn_document(:page_layout => :portrait  , :page_size => "A4", :left_margin => 9.mm, :top_margin => 14.mm, :right_margin => 9.mm, :bottom_margin => 14.mm) do |pdf|
  
  pdf.font_size 12.pt

  first = true
  
  @recipients.each do |r|
    adr = r.send(@address_type)
    next if adr.blank?
    pdf.start_new_page unless first
    first = false
    label_grid pdf,
      :width => 20.mm,
      :height => 99.mm,
      :columns => 1,
      :rows => 3,
      :padding_left => 117.mm,
      :padding_top => 35.mm do |pdf, x, y|
    
        pdf.font font_bold
        pdf.text_box "#{adr.name}", :at => [x, y]
        pdf.font font_light
        pdf.text_box "\n#{adr.location_s}", :at => [x, y]
    end
  end
end