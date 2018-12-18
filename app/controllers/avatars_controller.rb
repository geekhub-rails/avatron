class AvatarsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    current_user.avatars.create(url: params[:url])
  end

  def destroy
  end
end
