class SessionsController < ApplicationController
  before_action :check_email, only: :create

  def new
  end

  def create
    email = params.require(:email)
    user = User.find_by_email(email)

    if user
      sign_in user

      redirect_to pickups_path
    else
      flash.alert = "לא נמצא משתמש"

      redirect_to new_session_path
    end
  end

  def destroy
    sign_out

    redirect_to new_session_path
  end

  private

  def check_email
    if params[:email].blank?
      flash.alert = "לא נמצא משתמש"

      redirect_to new_session_path
    end
  end
end
