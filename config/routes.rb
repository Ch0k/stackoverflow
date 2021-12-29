Rails.application.routes.draw do
  concern :votable do
    member do
      get :vote
      get :delete_vote
      get :unvote
      get :delete_unvote
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
