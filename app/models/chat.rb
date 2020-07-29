class Chat < ApplicationRecord
  after_save :notify_pusher
  def notify_pusher
    Pusher.trigger('presence-user', 'chat-all', self.as_json)
  end
end
