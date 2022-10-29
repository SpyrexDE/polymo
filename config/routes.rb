Rails.application.routes.draw do
  match '/profile/:id', :to => 'profile#show', :as => :profile, :via => :get
  match '/profile/:id/edit', :to => 'profile#edit', :as => :edit_profile, :via => :get
  devise_for :users
  devise_for :models
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'topics#index'

  resources :topics
end
