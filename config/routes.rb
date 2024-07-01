Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'dashboard', to: 'dashboard#index'
  end

  # Defines the root path route ("/")
  root 'index#index'
  get 'gallery', to: 'index#gallery'
end
