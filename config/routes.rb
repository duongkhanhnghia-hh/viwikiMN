Rails.application.routes.draw do

  resources :posts
  resources :comments
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get 'export', to: :export, controller: 'categories'
  post 'import', to: :import, controller: 'categories'
  get 'showall', to: :showall, controller: 'categories'
  post 'users/action' => 'users#action'
  post 'users/chooseRole' => 'users#chooseRole'
  resources :categories do
    member do
      post :reparent, :import
    end
    resources :posts do
      resources :comments
    end
  end

end
