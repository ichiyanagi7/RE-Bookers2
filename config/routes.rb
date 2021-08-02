Rails.application.routes.draw do
  root "homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users,only:[:index,:show,:edit,:update]

  resources :books do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end

  post "follow/:id" => "relationships#follow",as:"follow"
  post "unfollow/:id" => "relationships#unfollow",as:"unfollow"

end
