Rails.application.routes.draw do
  resource :session, only: %i[new create update destroy]
  root 'dashboards#show'
  get '/api/:hash', to: 'api/avatars#show'

	post 'profile', to: 'users#edit'
  post 'profile/add_number', to: 'users#add_number'
  get 'profile/add_number', to: 'users#add_number'
  delete 'profile', to: 'users#destroy'
  get 'profile', to: 'users#show'

  resources :phone_numbers, only: %i[new create update destroy] do
    patch '/', to: 'phone_numbers#update', on: :collection
  end
  resources :avatars, only: %i[create destroy]
end
