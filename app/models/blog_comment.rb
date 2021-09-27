class BlogComment < ApplicationRecord

  belongs_to :client
  belongs_to :blog

end
