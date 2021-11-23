Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:create]

  resources :companies, only: [] do
    member do
      get :slots
    end
  end
end
