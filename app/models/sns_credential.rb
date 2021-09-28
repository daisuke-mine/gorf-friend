class SnsCredential < ApplicationRecord
  
  belongs_to :client, optional: true
end
