class Client < ApplicationRecord

   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          # Omniauthを使用するためのオプション
         :omniauthable, omniauth_providers: %i[google_oauth2]
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_one_attached :profile_image
    has_many :blogs
    has_many :blog_comments
    has_many :sns_credentials, dependent: :destroy
    has_many :favorites, dependent: :destroy

    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followers, through: :reverse_of_relationships, source: :follower
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




    def self.without_sns_data(auth)
      client = Client.where(email: auth.info.email).first
      # binding.pry
        if client.present?
          sns = SnsCredential.create(
            uid: auth.uid,
            provider: auth.provider,
            client_id: client.id
          )
        else
          client = Client.create(
            name: auth.info.name,
            email: auth.info.email,
            password: "password"
          )
          sns = SnsCredential.new(
            uid: auth.uid,
            provider: auth.provider
          )
          # binding.pry
        end
      return { client: client ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    client = Client.where(id: snscredential.client_id).first
    unless client.present?
      client = Client.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    return {client: client}
   end

    def self.find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        client = with_sns_data(auth, snscredential)[:client]
        sns = snscredential
      else
        client = without_sns_data(auth)[:client]
        sns = without_sns_data(auth)[:sns]
      end
      return { client: client ,sns: sns}
    end
end
