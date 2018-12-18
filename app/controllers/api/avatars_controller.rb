class Api::AvatarsController < ActionController::Base
  respond_to? :json

  def show
    user_phone = UserPhone.find_by(md5_hash: params[:hash])
    if user_phone
      render :json => {status: 200, data: user_phone}
    else
      render :json => {status: 404, message: 'not found'}
    end
  end
end
