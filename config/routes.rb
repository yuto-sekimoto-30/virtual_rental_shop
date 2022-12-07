Rails.application.routes.draw do
  get 'movies/search'
  get 'movies/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'login', to: 'user_sessions#new'  # 追記
  post 'login', to: 'user_sessions#create'  # 追記
  delete 'logout', to: 'user_sessions#destroy'  # 追記
  root to: 'user_sessions#new'
  resources :users
  resources :password_resets, only: %i[new create edit update]
  get 'password_resets/done', to: 'password_resets#done' 
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end