Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  # この上のやつログイン後？後でチェック

  # git status見ながら正しいURLにくっつけた
  get 'home/about' => 'home#show', as: 'about'
  resources :home, only: [:new, :create, :show]
  # 試しにやってみたが違った。ただあとで使うかもしれないから保留。
  resources :users
  resources :books


  # root :to => 'user#index'
end
