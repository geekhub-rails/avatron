class User < ApplicationRecord
  has_many :phones, class_name: 'UserPhone', dependent: :delete_all
  has_many :avatars

  email_regex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/
  validates_format_of :email, multiline: true, with: email_regex, message: "Please enter a valid email address", allow_blank: true

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
  # private

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def confirm_new_email
    self.update(email: self.new_email, new_email: nil)
    self.validate_email
    self.save(validate: false)
  end

end
