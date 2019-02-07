require 'rails_helper'

RSpec.describe Avatar, type: :model do
  subject { Avatar.new(url: "http://res.cloudinary.com/dfw61a6zc/image/upload/v1548784620/avatron/nmph9pxnnhs7ffqokke2.png") }
  resized_image = "http://res.cloudinary.com/dfw61a6zc/image/upload/w_100,h_100,c_fit/v1548784620/avatron/nmph9pxnnhs7ffqokke2.png"

  describe '#resize_image' do
    it 'is resized' do
      expect(subject.resize_image(100)).to eq(resized_image)
    end
  end

end
