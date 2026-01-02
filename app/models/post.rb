class Post < ApplicationRecord
   extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_rich_text :body
  has_one_attached :banner_image
end
