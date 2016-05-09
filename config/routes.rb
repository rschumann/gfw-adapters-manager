Rails.application.routes.draw do
  resources :datasets, except: :destroy
  post 'reload/datasets',     to: 'datasets#refresh', as: 'refresh_datasets'
  post 'reload/datasets/:id', to: 'datasets#refresh', as: 'refresh_dataset'
  post 'datasets/:id/delete', to: 'datasets#destroy', as: 'delete_dataset'
  root to: 'datasets#index'
end
