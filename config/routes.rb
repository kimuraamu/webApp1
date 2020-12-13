Rails.application.routes.draw do

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"


  post "users/:id/update" => "users#update"
  post 'users/create' => "users#create"
  get "users/:id/edit" => "users#edit"
  get  'newuser' => "users#newuser"
  get 'users/:id'  => "users#show"


  get '/' => "home#top"



  get "index" => "posts#index"
  get "top" => "posts#top"
  get 'posts/newpos' => "posts#newpos"
  get 'posts/newindex' => "posts#newindex"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post  "posts/:id/destroy" => "posts#destroy"
  get 'posts/:id/newshow' => "posts#newshow"
  post 'posts/:id/create_tweet' => "posts#create_tweet" #掲示板に書き込み
  post 'posts/:id/destroy_tweet/:tid' => "posts#destroy_tweet"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
