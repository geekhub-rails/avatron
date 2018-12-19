Rails.application.routes.draw do
  resource :session, only: %i[new create update destroy]
  root 'dashboards#show'
  get '/api/:hash', to: 'api/avatars#show'

	post 'profile', to: 'users#edit'
  delete 'profile', to: 'users#destroy'
  get 'profile', to: 'users#show', as: "show_profile"
  patch 'phone_numbers', to: 'phone_numbers#update'

  resources :phone_numbers, only: %i[new create update destroy] do
    patch '/', to: 'phone_numbers#update', on: :collection
  end
  resources :avatars, only: %i[create destroy]
end
