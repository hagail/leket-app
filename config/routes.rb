Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'pickup_reports#new'

  scope :pickups do
    resources :pickup_reports, only: [:new, :create, :edit, :update]
  end
end
