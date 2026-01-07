class Sessions::OmniauthController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.save
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Signed in successfully via Google"
    else
      redirect_to new_session_path, alert: "Authentication failed. Please try again."
    end
  end
end
