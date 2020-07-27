class StaticPagesController < ApplicationController
  def home
    #10 course duoc join nhieu nhat
    @courses_ids= Join.group("course_id").order("count(user_id) DESC").limit(6).pluck("course_id")
    @courses = @courses_ids.map {|id| Course.find(id)}
    #10 nguoi hoc duoc nhieu tu nhat
    @users_ids = Study.group("user_id").order("count(word_id) DESC").limit(10).pluck("user_id")
    @users = @users_ids.map {|id| User.find(id)}
  end

  def about
  end
end
