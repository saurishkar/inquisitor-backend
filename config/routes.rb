Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions
  resources :answers
  resources :users do
    get '/logout' => 'users#logout'
  end
  post 'users/login' => 'users#login'
  get '/forgot_password' => 'users#forgot_password'
  post '/forgot_password', to: 'users#send_reset_password_mail', as: 'send_reset_password_mail'
  get '/reset_password' => 'users#reset_password'
  root 'home#index'
end
