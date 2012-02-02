# encoding: utf-8
module PdfGeneratorHelper
  
  def label_grid(pdf, options={})
    y = pdf.cursor - options[:padding_top]
    
    options[:rows].times do
      x = options[:padding_left]
      options[:columns].times do
        
        yield pdf, x, y
        
        x += options[:width]
      end
      y -= options[:height]
    end
  end
  
end