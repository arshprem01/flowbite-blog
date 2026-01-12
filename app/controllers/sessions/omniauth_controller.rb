class Sessions::OmniauthController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    new_user = user.new_record?
    if user.save
      start_new_session_for user
      msg= new_user ? "Signed up successfully via Google" : "Signed in successfully via Google"
      redirect_to after_authentication_url, notice: msg
    else
      redirect_to new_session_path, alert: "Authentication failed. Please try again."
    end
  end
end
