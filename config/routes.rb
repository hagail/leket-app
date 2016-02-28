Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'sessions#new'

  resources :pickups, only: [:index] do
    resources :pickup_reports, only: [:new, :update], shallow: true
    member do
      post :approve
      post :unapprove
    end
    post "not_picked" => "pickups#mark_as_not_picked"
  end

  resource :session, only: [:new, :create, :destroy]

  get "thank_you" => "pickups#thank_you"


  get "pickups/summary", to: "pickup_reports#summary"

  resources :container_reports, only: [:update]
end
