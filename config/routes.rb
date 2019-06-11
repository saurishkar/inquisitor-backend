Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions
  resources :answers
  resources :users do
    get '/logout' => 'users#logout'
  end
  post 'users/login' => 'users#login'
  root 'home#index'
end
