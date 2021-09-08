class Blog < ApplicationRecord

  has_many_attached :images
  has_many :favorites
  belongs_to :client

end
