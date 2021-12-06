Rails.application.routes.draw do
  resources :professionals
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'professionals#index'
  
  resources :users
  resources :professionals do
    resources :appointments
  end
end