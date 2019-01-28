require 'rails_helper'

RSpec.describe UserPhone, type: :model do
  subject { UserPhone.new(number: '+380631231231') }

  describe '#confirmed?' do
    it 'is confirmed' do
      expect(subject).to be_confirmed
    end

    it 'is not confirmed' do
      subject.code = '1111'
      expect(subject).to_not be_confirmed
    end
  end

  describe '#generate_code' do
    it 'generates sms code' do
      subject.run_callbacks :create
      expect(subject.code).to_not be_blank
    end
  end

  describe '#generate_hash' do
    it 'generates hash' do
      subject.run_callbacks :create
      expect(subject.md5_hash).to_not be_blank
    end
  end

end
