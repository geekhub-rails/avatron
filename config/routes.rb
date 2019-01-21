Rails.application.routes.draw do
  resource :session, only: %i[new create update destroy]
  root 'dashboards#show'
  get '/api/:hash', to: 'api/avatars#show'

  post 'profile', to: 'users#edit'
  delete 'profile', to: 'users#destroy'
  get 'profile', to: 'users#show', as: 'show_profile'

  resources :phone_numbers, only: %i[new create update destroy] do
    patch '/', to: 'phone_numbers#updates', on: :collection
    get 'confirm', to: 'phone_numbers#confirm_number', on: :member, as: :confirm
  end
  get '/:token/confirm_email/', to: 'users#update', as: 'confirm_email'

  resources :avatars, only: %i[create destroy]
end
