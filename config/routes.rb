Rapture::Application.routes.draw do
  
  get "address_stickers_controller/address_stickers_24"

  get "address_stickers_controller/address_stickers_3"

  get "address_stickers_controller/envelope_c5"

  devise_for :users, :path => '' # , :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  
  root :to => 'customers#index'
  
  resources :customers do
    collection do
      post :download
      post :search
    end
  end
  resources :users
  resources :languages
  resources :country
    
  match '/settings', :to => 'users#index'
  
  match '/new_customer_duration', :to => 'customers#new_customer_duration', :via => 'post'
  
  namespace "pdfs" do
    match "address_stickers_24" => "address_stickers#address_stickers_24", :defaults => {:format => "pdf"}
    match "address_stickers_3" => "address_stickers#address_stickers_3", :defaults => {:format => "pdf"}
    match "envelope_c5" => "address_stickers#envelope_c5", :defaults => {:format => "pdf"}
    
    match "router" => "address_stickers#router", :defaults => {:format => "pdf"}
  end
  
end
