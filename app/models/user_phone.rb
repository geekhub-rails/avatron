class UserPhone < ApplicationRecord
  belongs_to :user
  belongs_to :avatar, optional: true

  number_regex = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
  validates :number, presence: true, length: { minimum: 4 }
  validates_format_of :number, :with =>  number_regex, :message => "Please enter a valid phone"

  before_create :generate_hash, :generate_code

  accepts_nested_attributes_for :user

  def confirmed?
    code.nil?
  end

  def generate_code
    #self.code = Rails.env.production? ? rand(1000..9999) : 1111
    self.code = 1111
  end
  
  private

  def generate_hash
    self.md5_hash = Digest::MD5.hexdigest(number)
  end
end
