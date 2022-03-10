Rails.application.routes.draw do
  concern :votable do
    member do
      post :vote
      post :delete_vote
      post :unvote
      post :delete_unvote
    end
  end
  devise_for :users
  root to: "questions#index"
  resources :badges
  resources :questions, concerns: [:votable] do
    resources :answers, concerns: [:votable], shallow: true, only: [:create, :update, :destroy] do
      member do
        delete :delete_file_attachment
      end
    end
    member do
      delete :delete_file_attachment
    end
  end
end
