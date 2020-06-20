Rails.application.routes.draw do

  resource :user, only: [:new, :update, :destroy]
  resources :movies, only: [:new, :update, :destroy] do
    member do
      get 'add_genre'
      get 'like'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
