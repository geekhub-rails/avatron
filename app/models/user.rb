class User < ApplicationRecord
  has_many :phones, class_name: 'UserPhone', dependent: :delete_all
  has_many :avatars
  
  def auto_create_gravatar
    unless self.email.blank?
      unless self.avatars.where("url like ?", "%gravatar%").exists?
        hash = Digest::MD5.hexdigest self.email
        url = "https://www.gravatar.com/avatar/#{hash}"
        self.avatars.create(url: url)
      end
    end
  end
end
