class Relationship < ApplicationRecord
  belongs_to  :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  after_save :notify_pusher
  def notify_pusher
    Pusher.trigger("user-#{User.find(self.followed_id).name}", 'follow', {
      user_name: User.find(self.follower_id).name
    })
  end
end
