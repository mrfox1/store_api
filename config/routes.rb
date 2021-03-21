Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %I[show create] do
        collection do
          get :profile
          put :profile, action: :update
          delete :profile, action: :destroy
        end
      end

      resources :sessions, only: %I[create] do
        collection do
          delete :logout, action: :destroy
        end
      end
    end
  end
end
