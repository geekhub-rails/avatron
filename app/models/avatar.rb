class Avatar < ApplicationRecord
  belongs_to :user
  has_one :user_phone
end
