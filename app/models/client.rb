class Client < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_one_attached :profile_image
    has_many :blogs
    has_many :brog_comments
    has_many :sns_credentials, dependent: :destroy
    has_many :favorites, dependent: :destroy

    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :reverse_of_relationships, source: :follower

    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followings, through: :relationships, source: :followed

    def following?(client)
      followings.include?(client)
    end

    def follow(client_id)
      relationships.create(followed_id: client_id)
    end

    def unfollow(client_id)
      relationships.find_by(followed_id: client_id).destroy
    end


    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
            # Omniauthを使用するためのオプション
           :omniauthable, omniauth_providers: %i[facebook google_oauth2]

    def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

    def self.find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      return { user: user ,sns: sns}
    end
end
