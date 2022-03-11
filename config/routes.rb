Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  concern :votable do
    member do
      post :vote, :unvote
      delete :revote
    end
  end
  resources :badges
  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true, only: [:create, :update, :destroy] do
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
end
