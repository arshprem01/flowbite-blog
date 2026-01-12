class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, on: :create, unless: -> { provider.present? }

  def self.from_omniauth(auth)
    where(email_address: auth.info.email).first_or_initialize do |user|
      user.email_address = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = SecureRandom.hex(10) if user.new_record?
    end
  end
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true

  enum :role, [ :subscriber, :admin ]
end
