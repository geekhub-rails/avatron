class UserPhone < ApplicationRecord
  belongs_to :user
  belongs_to :avatar, optional: true

  validates :number, presence: true

  before_create :generate_hash, :generate_code

  accepts_nested_attributes_for :user

  def confirmed?
    code.nil?
  end

  private

  def generate_code
    self.code = Rails.env.production? ? rand(1000..9999) : 1111
  end

  def generate_hash
    self.md5_hash = Digest::MD5.hexdigest(number)
  end
end
