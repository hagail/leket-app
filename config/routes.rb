Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'sessions#new'

  resources :pickups, only: [:index] do
    resources :pickup_reports, only: [:new, :update], shallow: true

    post 'not_picked' => 'pickups#mark_as_not_picked'
    post 'reset_picked' => 'pickups#sr_reset_picked'
  end

  resources :supplier_reports, only: :update
  resource :session, only: [:new, :create, :destroy]

  get 'thank_you' => 'pickups#thank_you'

  get 'admin/summary', to: 'admin#summary', as: :pickups_summary
  post 'admin/csv', to: 'admin#create_csv'
  post 'pickup_reports/:id/approve', to: 'admin#approve'
  post 'pickup_reports/:id/unapprove', to: 'admin#unapprove'
  post 'container_reports/:id/approve', to: 'admin#container_approve'
  post 'container_reports/:id/unapprove', to: 'admin#container_unapprove'
  get 'dropbox/authorize', to: 'admin#dropbox_authorization'
  get 'dropbox/callback', to: 'admin#dropbox_callback'

  resources :container_reports, only: [:update]
end
