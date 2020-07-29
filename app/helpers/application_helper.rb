module ApplicationHelper
  
  def avatar_url(user)
    if user.picture?
      user.picture.url 
    elsif user.uid.present?
      user.image
    else
      # "default_img.png"
      # asset_path("default_img.png")
      ActionController::Base.helpers.asset_path("default_img.png")
    end
  end

end
