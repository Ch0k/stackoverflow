Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :badges
  resources :questions do
    resources :answers, shallow: true, only: [:create, :update, :destroy] do
      member do
        delete :delete_file_attachment
        get :vote
        get :unvote
      end
    end
    member do
      delete :delete_file_attachment
      get :vote
      get :unvote
    end
  end
end
