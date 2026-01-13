class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create_commit :notify_author

  private

  def notify_author
    return if post.user == user
    Notification.create(recipient: post.user, actor: user, notifiable: self, action: "commented")
  end
end
