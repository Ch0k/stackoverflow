Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks'}
  
  root to: "questions#index"
  concern :votable do
    member do
      post :vote, :unvote
      delete :revote
    end
  end
  resources :badges
  resources :questions, concerns: :votable do
    resources :comments, only: [:create]
    resources :answers, concerns: :votable, shallow: true, only: [:create, :update, :destroy] do
      resources :comments, only: [:create]
      member do
        delete :delete_file_attachment
      end
    end
    member do
      post :vote
      post :unvote
      delete :delete
      delete :delete_file_attachment
    end
  end
  mount ActionCable.server => '/cable'
end
