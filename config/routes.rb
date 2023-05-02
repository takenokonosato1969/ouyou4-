Rails.application.routes.draw do
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  get "search" => "searches#search"
  resources :chats, only: [:show, :create]

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    get 'search_form' => 'users#search_form'
    get "daily_posts" => "users#daily_posts"
  end
  resources :groups do
    get "join" => "groups#join"
  end

end
