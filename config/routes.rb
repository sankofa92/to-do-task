Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  
  post 'change_locale', to: 'application#change_locale'

  resources :tasks do
    collection do
      get 'status', to: 'tasks#index'
      # get :pending
      # get :doing
      # get :finish
    end
  end
end
