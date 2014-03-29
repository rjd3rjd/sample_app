# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy

  before_save { |user| user.email = email.downcase } # before_save { self.email.downcase! } # also would work
  before_create :create_remember_token

  validates(:name, presence: true, length: { maximum: 50 })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false})
  validates :password, length: { minimum: 6 }
  # validates :password_confirmation, presence: true

  has_secure_password

  def feed
    Micropost.where("user_id = ?", id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest_token(User.new_remember_token)
    end
end
