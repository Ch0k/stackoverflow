Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :badges
  resources :questions do
    resources :answers, shallow: true, only: [:create, :update, :destroy] do
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
