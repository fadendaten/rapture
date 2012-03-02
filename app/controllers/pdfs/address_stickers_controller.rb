class Pdfs::AddressStickersController < ApplicationController
  
  before_filter :find_addressable, :find_address_type
  
  #FIX: ? needed for forms
  def router
    render :action => params[:template]
  end
  
  def address_stickers_24 ; end
  def address_stickers_3 ; end
  def envelope_c5 ; end
  
  
  protected
  
    def find_addressable
      @recipients = []
      params.each do |name, value|
        if name =~ /(.+)_ids$/
          @recipients << $1.classify.constantize.find(value)
        end
      end
      @recipients.flatten!
      if @recipients.empty?
        flash[:alert] = "SYSTEMFEHLER! Kein Emfpaenger gefunden."
        redirect_to :root
      end
      nil
    end
    
    def find_address_type
      @address_type = params[:address_type] || :contact_address
    end
  
end
