class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image
  has_many :brogs
  has_many :brog_comments
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
