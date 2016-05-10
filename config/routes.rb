Rails.application.routes.draw do
  devise_for :users
  resources :datasets, except: [:update, :destroy]
  post 'reload/datasets',     to: 'datasets#refresh', as: 'refresh_datasets'
  post 'reload/datasets/:id', to: 'datasets#refresh', as: 'refresh_dataset'
  post 'datasets/:id/delete', to: 'datasets#destroy', as: 'delete_dataset'
  post 'datasets/:id/edit',   to: 'datasets#update',  as: 'update_dataset'

  resources :users, except: [:destroy, :new, :create, :edit, :update] do
    patch 'deactivate', on: :member
    patch 'activate',   on: :member
    patch 'make_admin', on: :member
    patch 'make_user',  on: :member

    get    'info/edit', to: 'users#edit_info',   as: :edit_info
    put    'info',      to: 'users#update_info', as: :update_info
    delete 'delete',    to: 'users#destroy',     as: :delete
  end

  root to: 'home#index'
end
