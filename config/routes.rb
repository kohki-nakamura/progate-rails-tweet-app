Rails.application.routes.draw do
  post "/likes/:post_id/" => "likes#create"
  delete "/likes/:post_id" => "likes#destroy"

  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "users/index" => "users#index"
  get "users/:id/likes" => "users#likes"
  get "users/:id" => "users#show"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  patch "users/:id" => "users#update"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  patch "posts/:id/" => "posts#update"
  delete "posts/:id" => "posts#destroy"

  get "/" => "home#top"
  get "/about" => "home#about"
end
