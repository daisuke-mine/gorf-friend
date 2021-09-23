class Blog < ApplicationRecord

  has_many_attached :images
  has_many :favorites, dependent: :destroy
  belongs_to :client
  has_many :post_comments, dependent: :destroy

  def favorited_by?(client)
    favorites.where(client_id: client.id).exists?
  end

end
