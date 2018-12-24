class Avatar < ApplicationRecord
  belongs_to :user_phone, optional: true
end
