class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image
  has_many :brogs
  has_many :brog_comments
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_for_oauth(auth)
     user = User.where(uid: auth.uid, provider: auth.provider).first

     unless user
      user = User.create(
        uid:      auth.nickname,
        name:     auth.info.name,
        image:    auth.info.image,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
     end
     user
  end

   private

   def self.dummy_email(auth)
     "#{auth.uid}-#{auth.provider}@example.com"
   end
end
