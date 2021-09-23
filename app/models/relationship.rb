class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Client"
  belongs_to :followed, class_name: "Client"
end
