class PickupsController < ApplicationController
  def index
    # current_user by email :)
    @user = User.first
  end

  def thank_you
    render layout: false
  end
end
