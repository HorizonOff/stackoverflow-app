class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  mount_uploader :avatar, AvatarUploader

  enum role: %i[customer moderator admin]

  has_many :messages, inverse_of: :user
  has_many :votes

  has_one :location, dependent: :destroy

  validates :login, presence: { message: 'Login is required' },
            uniqueness: { case_sensitive: false, message: 'Current login already exist' }

  validates :facebook_id, uniqueness: true, allow_blank: true

  validates_presence_of :avatar

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(facebook_id: auth.uid).first_or_create do |u|
      u.email = auth.info.email
      u.password = Devise.friendly_token[0,20]
      u.login = auth.info.email.split('@').first
      u.remote_avatar_url = auth.info.image
    end
  end
end
