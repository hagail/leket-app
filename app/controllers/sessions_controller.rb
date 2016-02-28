class SessionsController < ApplicationController
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
end
