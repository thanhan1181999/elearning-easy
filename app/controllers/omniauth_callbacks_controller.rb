class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("facebook")
  end

  def google_oauth2
    generic_callback("google_oauth2")
  end

  def generic_callback(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    flash[:success]="Log in success!"
    log_in @user
    redirect_to @user
  end

  def failure
    puts "failure"
    redirect_to root_path
  end

end