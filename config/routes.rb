Rails.application.routes.draw do
  resources :dishes, except: [:show]

  root to: 'dishes#index'
end
