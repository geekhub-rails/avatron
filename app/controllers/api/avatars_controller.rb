require 'open-uri'
# require "mini_magick"

class Api::AvatarsController < ActionController::Base
  respond_to? :json
  Mime::Type.register "image/jpg", :jpg
  caches_action :show

  def show
    user_phone = UserPhone.find_by(md5_hash: params[:hash])
    avatar = Avatar.find_by(user_id: user_phone && user_phone.user_id)
    if avatar
      file = open(avatar.url).read
      size = params['size'] || params['s']
      if size
        file = MiniMagick::Image.open(avatar.url)
        puts "#{size}x#{size}"
        file.resize("#{size}x#{size}")
      end
      send_data file, type: 'image/png', disposition: 'inline'
      # render :json => "data:image/png;base64,#{Base64.encode64(file)}"
    else
      render :json => {status: 404, message: 'not found'}
    end
  end
end
