require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_without_gravatar) { User.create(email: 'user@gmail.com') }
  let(:user_with_gravatar) { User.create(email: 'super-avatron2018@mail-apps.com') }


  describe '#auto_create_gravatar' do
  hash = Digest::MD5.hexdigest 'user@gmail.com'
  url = "https://www.gravatar.com/avatar/#{hash}"
  grava_url = 'https://www.gravatar.com/avatar/f11953cb2ee56b60df049b312745a406'

    it 'is creates new avatar with gravatar url for user with email' do
    	user_without_gravatar.auto_create_gravatar
      expect(user_without_gravatar.avatars.last.url).to eq(url)
    end

    it 'is updates url' do
    	user_with_gravatar.avatars.create(url: 'https://www.fvfv.com/qqq')
    	user_with_gravatar.auto_create_gravatar
    	expect(user_with_gravatar.avatars.last.url). to eq(grava_url)
    end

    it 'is returns nil for user without email' do
    	user_without_gravatar.email = ''
    	user_without_gravatar.auto_create_gravatar
      expect(user_without_gravatar.avatars.last).to be_nil
    end
  end
end
