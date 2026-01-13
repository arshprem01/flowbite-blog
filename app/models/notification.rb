class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  after_create_commit do
    broadcast_prepend_to recipient, :notifications, target: "notifications_list", partial: "notifications/notification", locals: { notification: self }
    broadcast_replace_to recipient, :notifications, target: "notification_bell", partial: "shared/notification_bell", locals: { user: recipient }
  end
end
