require 'spec_helper'

describe Pdfs::AddressStickersControllerController do

  describe "GET 'address_stickers_24'" do
    it "returns http success" do
      get 'address_stickers_24'
      response.should be_success
    end
  end

  describe "GET 'address_stickers_3'" do
    it "returns http success" do
      get 'address_stickers_3'
      response.should be_success
    end
  end

  describe "GET 'envelope_c5'" do
    it "returns http success" do
      get 'envelope_c5'
      response.should be_success
    end
  end

end
