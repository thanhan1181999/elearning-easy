class StaticPagesController < ApplicationController
  def home
    #10 course duoc join nhieu nhat

    #10 nguoi hoc duoc nhieu tu nhat
    @ids = Study.group("user_id").order("count(word_id) DESC").limit(5).pluck("user_id")
    @users = User.where(id:@ids) 
  end

  def about
  end
end
