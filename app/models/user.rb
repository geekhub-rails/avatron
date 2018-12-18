class User < ApplicationRecord
  has_many :phones, class_name: 'UserPhone', dependent: :delete_all
  has_many :avatars
end
