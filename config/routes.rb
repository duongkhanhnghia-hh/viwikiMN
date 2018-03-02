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
  get 'entries', to: :entry, controller: 'categories'
  get 'versions' => 'versions#index'
  get '_list_categories', to: :_list_categories, controller: 'categories'
  post 'users/action' => 'users#action'
  post 'users/chooseRole' => 'users#chooseRole'
  post 'categories/edit_description' => 'categories#edit_description'

  post 'categories/edit_description' => 'categories#edit_description'
  
 post 'categories/create-comment' => 'categories#create_comment'
  post 'categories/create-post' => 'categories#create_post'
  resources :categories do
    member do
      post :reparent, :import
      get :description
      get :details
      post :edit__description
    end
    resources :posts 
    resources :comments
  end

end
