class AvatarsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @user = current_user
    @avatars = @user.avatars
    @avatars.create(url: params[:url])
  end

  def destroy
    avatar = Avatar.find(params[:id])
    avatar.destroy
    redirect_to :root
  end
end
