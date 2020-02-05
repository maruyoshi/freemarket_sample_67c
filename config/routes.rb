Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  
  root "products#index"
  get '/products/new', to: 'products#new'
  get '/mypage', to: 'mypage#index'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/card/credit', to: 'mypage#credit'
  get '/mypage/logout', to: 'mypage#logout'
end