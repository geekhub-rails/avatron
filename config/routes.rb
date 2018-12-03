Rails.application.routes.draw do
  resource :session
  root 'dashboards#show'
  patch 'dashboards/update-image', to: 'dashboards#update_image'
  patch 'dashboards/save-images', to: 'dashboards#save_images'
  get 'dashboards/choose-image', to: 'dashboards#choose_image'
end
