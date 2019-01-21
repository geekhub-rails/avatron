require 'open-uri'

class Api::AvatarsController < ActionController::Base
  respond_to? :json
  Mime::Type.register "image/jpg", :jpg
  caches_page :show

  def show
    user_phone = UserPhone.find_by(md5_hash: params[:hash])
    avatar = user_phone&.avatar
    if avatar
      size = params['size'] || params['s']
      if size
        file = open(avatar.resize_image(size)).read
      else
        file = open(avatar.url).read
      end
      send_data file, type: 'image/png', disposition: 'inline'
    else
      file = open('https://i.imgur.com/Ur1pWL4.png').read
      send_data file, type: 'image/png', disposition: 'inline'
    end
  end
end
