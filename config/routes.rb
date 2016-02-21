Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'pickup_reports#new'

  get "pickups/summary", to: "pickup_reports#summary"
  scope "pickups/(:pickup_id)"  do
    resources :pickup_reports, only: [:index, :new, :update] do
      member do
        post :approve
        post :unapprove
      end
    end
  end

  resources :container_reports, only: [:update]
end
