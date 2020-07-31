class Join < ApplicationRecord
  belongs_to :user
  belongs_to :course
  after_save :notify_pusher
  def notify_pusher
    Pusher.trigger("user-#{Course.find(course_id).user.name}", 'new-join-course',{
      user_name:  User.find(self.user_id).name,
      course_name: Course.find(self.course_id).name
    })
  end
end
