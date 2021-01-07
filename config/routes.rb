Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update]
  resources :users, only: [:index, :show, :edit, :update] do
 	resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
 	get 'followers' => 'relationships#followers', as: 'followers'
  end
  get '/search', to: 'search#search'
end
