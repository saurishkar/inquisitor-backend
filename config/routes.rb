# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: redirect('/admin/login')
  ###############################################################################################
  #                             INQUISITOR ADMIN ROUTES STARTS HERE                             #
  ###############################################################################################

  namespace :admin do
    get '/login' => 'home#index'
    resources :questions
    resources :answers
    resources :users do
      get '/logout' => 'users#logout'
    end
    post '/login' => 'users#login'
    get '/forgot_password' => 'users#forgot_password'
    post '/forgot_password', to: 'users#send_reset_password_mail', as: 'send_reset_password_mail'
    get '/reset_password' => 'users#reset_password'
  end

  ###############################################################################################
  #                              INQUISITOR API ROUTES STARTS HERE                              #
  ###############################################################################################

  namespace :api do
    namespace :v1 do
      post '/users/token' => 'users#token'
      post '/users' => 'users#create'
    end
  end

  ###############################################################################################
end
