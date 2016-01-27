Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'pickup_reports#new'

  resources :pickups, only: [:index] do
    resources :pickup_reports, only: [:new, :update], shallow: true

    post "not_picked" => "pickups#mark_as_not_picked"
  end

  get "thank_you" => "pickups#thank_you"
end
