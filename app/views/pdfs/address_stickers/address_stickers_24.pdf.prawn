#encoding: utf-8
require "prawn/measurement_extensions"


prawn_document(:page_layout => :portrait  , :page_size => "A4", :left_margin => 9.mm, :top_margin => 14.mm, :right_margin => 9.mm, :bottom_margin => 14.mm) do |pdf|
  
  pdf.font_size 10.pt
  
  padding_top = 8.mm  
  padding_top -= (@address.to_s.count("\n") - 2) * 3.mm
  
  first = true
  @recipients.each do |r|
    adr = r.send(@address_type)
    next if adr.blank?
    pdf.start_new_page unless first
    first = false
    label_grid pdf,
      :width => 64.6.mm,
      :height => 33.8.mm,
      :columns => 3,
      :rows => 8,
      :padding_left => 10.mm,
      :padding_top => padding_top do |pdf, x, y|
    
        pdf.font font_bold
        pdf.text_box "#{adr.name}", :at => [x, y]
        pdf.font font_light
        pdf.text_box "\n#{adr.location_s}", :at => [x, y]
    end
  end
end