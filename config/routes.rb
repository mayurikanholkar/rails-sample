Rails.application.routes.draw do
  resources :movies
  resources :movies do
    member do
      put 'like' => "movies#upvote"
      put 'unlike' => "movies#downvote"       
    end
  end
  resources :charges  
  root :to =>'home#index'  
  get 'dashboard' => 'home#dashboard'
  get 'listing_user' => 'home#listing_user'
  devise_for :members,:controllers => { :registrations =>'registration'} 
  get 'member/show/:id' => "home#show", as: 'show'
  get 'member/edit/:id' => "home#edit", as: 'edit'
  post '/update/:id' => "home#update"
  put '/update/:id' => "home#update"
  patch '/update/:id' => "home#update", as: 'member_update'
  mount Commontator::Engine => '/commontator'
  get "/send_sms" =>"home#send_sms", :as => "send_sms"
  get "/otp_verify" => "home#otp_verify", :as => "otp_verify" 
  post 'update_cropping_image', to: 'movies#update_cropping_image', as: 'update_cropping_image'      
end
