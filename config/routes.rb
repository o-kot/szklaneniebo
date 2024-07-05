Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
    get 'dashboard', to: 'dashboard#index'
    patch 'update_author_photo', to: 'dashboard#update_author_photo'
    patch 'update_author_about', to: 'dashboard#update_author_about'
    post 'create_category', to: 'dashboard#create_category'
    post 'add_photos', to: 'dashboard#add_photos'
  end

  # Defines the root path route ("/")
  root 'index#index'
  get 'gallery', to: 'index#gallery'
end
