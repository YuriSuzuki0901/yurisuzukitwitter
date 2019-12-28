Rails.application.routes.draw do

  root 'tweets#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',

}
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end



  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows
      get :followers
    end
  end  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]

end
