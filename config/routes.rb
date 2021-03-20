Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: %I[create] do
        collection do
          delete :logout, action: :destroy
        end
      end
    end
  end
end
