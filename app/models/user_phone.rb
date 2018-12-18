class UserPhone < ApplicationRecord
  belongs_to :user

  validates :number, presence: true

  after_create :generate_hash

  accepts_nested_attributes_for :user

  def confirmed?
    code.nil?
  end

  def update_code
    update_column(:code, Rails.env.production? ? rand(1000..9999) : 1111)
  end

  private

  def generate_hash
    self.md5_hash = Digest::MD5.hexdigest(self.number)
    self.save
  end
end
