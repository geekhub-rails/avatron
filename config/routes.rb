Rails.application.routes.draw do
  resource :session, only: %i[create update destroy]
  root 'dashboards#show'
  # namespace :api do ||
  #   get 'avatar/:hash', to: 'api#get_avatar'
  # end
  # scope '/api' do
  #   get '/avatar/:hash', to: 'api#get_avatar'
  # end
  get '/api/:hash', to: 'api/avatars#show'

	post 'profile', to: 'users#edit'
  post 'profile/add_number', to: 'users#add_number'
  get 'profile/add_number', to: 'users#add_number'
  delete 'profile', to: 'users#destroy'
  get 'profile', to: 'users#show'

  resources :phone_numbers, only: %i[create destroy]
  resources :avatars, only: %i[create destroy]
end
