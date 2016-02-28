module AuthenticationHelper
  extend ActiveSupport::Concern

  def authenticate_user!
    unless user_signed_in?
      flash.alert = "אנא התחבר מחדש"

      redirect_to new_session_path
    end
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    User.from_session(session) rescue nil
  end

  def sign_in(user)
    reset_session

    user.save_in_session(session)
  end

  def sign_out
    reset_session
  end

  ActiveSupport.on_load(:action_controller) do
    helper_method :current_user, :user_signed_in?
  end
end
