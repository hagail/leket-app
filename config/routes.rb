Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'pickup_reports#new'

  resources :pickups, only: [:index] do
    resources :pickup_reports, only: [:new, :update], shallow: true
  end

  get "thank_you" => "pickups#thank_you"

  # scope "pickups/:id" do
  # end
end
