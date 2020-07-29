class Chat < ApplicationRecord
  after_save :notify_pusher
  def notify_pusher
    Pusher.trigger('chat-channel', 'chat-event', self.as_json)
  end
end
