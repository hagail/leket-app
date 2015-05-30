Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'pickups#test'

  scope :pickups do
    resources :pickup_reports, only: [:new, :create, :edit, :update]
  end
end
