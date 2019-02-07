class DashboardsController < ApplicationController
  before_action :require_user
  include Rails.application.routes.url_helpers

  def show
    @user = current_user
    @avatars = current_user.avatars
    @phones = confirmed_phones
    @user.auto_create_gravatar if @user.email_confirmed?
  end

  def update_image
    confirmed_phones.each do |phone|
      phone.attach(params[:button])
    end
  end

  def choose_image
    @user = current_user
    @phone = @user.find_by(phone: params[:id])
  end

  def save_images
    @user = current_user

    User.transaction do
      if @user.update(user_params)
        if params[:user][:avatars]
          @user.avatars.attach(params[:user][:avatars])
          redirect_to root_path
        else
          p 'have no user.avatar'
        end
      else
        p 'cant update user'
      end
    end
  end

  private

  def user_params
    params.fetch(:avatars, {}).permit(:email, avatars: [])
  end

end
