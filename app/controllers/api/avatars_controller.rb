require 'open-uri'

class Api::AvatarsController < ActionController::Base
  respond_to? :json
  Mime::Type.register "image/jpg", :jpg
  caches_page :show

  def show
    user_phone = UserPhone.find_by(md5_hash: params[:hash])
    avatar = Avatar.find_by(user_id: user_phone && user_phone.user_id)
    if avatar
      size = params['size'] || params['s']
      if size
        file = open(avatar.resize_image(size)).read
      else
        file = open(avatar.url).read
      end
      send_data file, type: 'image/png', disposition: 'inline'
    else
      render :json => {status: 404, message: 'not found'}
    end
  end
end
