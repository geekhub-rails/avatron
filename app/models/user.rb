class User < ApplicationRecord
  has_many :phones, class_name: 'UserPhone', dependent: :delete_all
  has_many :avatars
  
  def auto_create_gravatar
    hash = Digest::MD5.hexdigest self.email
    url = "https://www.gravatar.com/avatar/#{hash}"
    unless self.email.blank?
      unless self.avatars.where("url like ?", "%gravatar%").exists?
        self.avatars.create(url: url)
      else
        grava = self.avatars.where("url like ?", "%gravatar%").take
        grava.update(url: url)
      end
    end
  end
end
