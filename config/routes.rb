Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :questions do
    resources :answers, shallow: true, only: [:create, :update, :destroy]
    member do
      delete :delete_file_attachment
    end
  end
end
