Rails.application.routes.draw do  
  resources :votes
  resources :comments
  resources :posts
  resources :comments
  resources :posts do
     resources :comments
  end 
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'export', to: :export, controller: 'categories'
  post 'import', to: :import, controller: 'categories'

  resources :categories do
    member do
      post :reparent, :import
    end
    resources :posts do
      resources :comments
      resources :votes
    end
  end
end
