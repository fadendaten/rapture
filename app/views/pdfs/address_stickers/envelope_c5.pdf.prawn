#encoding: utf-8
require "prawn/measurement_extensions"


prawn_document(:page_layout => :landscape  , :page_size => "C5") do |pdf|
  #, :left_margin => 9.mm, :top_margin => 14.mm, :right_margin => 9.mm, :bottom_margin => 14.mm
  pdf.font_size 12.pt


  
  x = 120.mm
  y = 67.mm
  first = true  
  @recipients.each do |r|
    adr = r.send(@address_type)

    next if adr.blank?

    pdf.start_new_page unless first
    first = false

    pdf.font font_bold
    pdf.text_box "#{adr.name}", :at => [x, y]
    pdf.font font_light
    pdf.text_box "\n#{adr.location_s}", :at => [x, y]
  end
end