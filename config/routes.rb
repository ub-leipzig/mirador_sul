Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :collections do
    resources :manifests, only: [:create, :destroy]
    resources :workspaces, only: [:new, :create]
  end

  resources :workspaces, only: [:index, :show, :destroy, :edit, :update]
  resources :annotations, param: :uuid, except: [:new, :edit ], defaults: { format: :json }

  mount MiradorRails::Engine, at: MiradorRails::Engine.locales_mount_path
end
