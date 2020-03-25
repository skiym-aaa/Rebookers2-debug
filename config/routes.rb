Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }

  # letter_opener用のルーティング
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'home#top'
  get 'home/about' => 'home#about'
  get '/search', to: 'search#search'

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :books,only: [:index,:show,:create,:edit,:update,:destroy] do
    resource :favorites, only:[:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
end
