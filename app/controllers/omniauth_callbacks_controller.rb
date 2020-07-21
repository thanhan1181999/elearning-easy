class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("facebook")
  end

  def google_oauth2
    generic_callback( "google_oauth2" )
  end

  def generic_callback(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    flash[:success]="Welcome back !" if @user.persisted?
    flash[:success]="Welcome !" unless @user.persisted?
    log_in @user
    redirect_to root_path   
  end

  def failure
    puts "failure"
    redirect_to root_path
  end
end