class Post < ApplicationRecord
   extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_rich_text :body
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_one_attached :banner_image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :search, ->(query) { where("title LIKE ?", "%#{query}%") }

  def self.related_to(post)
    return none if post.nil?

    keywords = post.title.to_s.downcase.gsub(/[^a-z0-9\s]/, "").split.select { |w| w.length > 3 }
    return none if keywords.empty?

    query = keywords.map { "lower(title) LIKE ?" }.join(" OR ")
    params = keywords.map { |w| "%#{w}%" }

    where(query, *params).where.not(id: post.id)
  end
  after_create_commit :notify_users

  private

  def notify_users
    User.where.not(id: user_id).find_each do |recipient|
      Notification.create(recipient: recipient, actor: user, notifiable: self, action: "posted")
    end
  end
end
