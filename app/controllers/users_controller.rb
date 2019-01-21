class UsersController < ApplicationController
  before_action :require_user
  def new
  end

  def create
  end
  
  def edit
    @user = current_user
    @user.update(new_email: user_params[:email])
    @user.set_confirmation_token
    @user.save(validate: false)
    UserMailer.confirm_email(@user).deliver_now
    render :js => "alert('Please confirm your email');"
  end

  def update
    @user = User.find_by_confirm_token(params[:token])
    @user.update(email: @user.new_email, new_email: nil)
    @user.validate_email
    @user.save(validate: false)
    redirect_to :profile
  end

  def show
    @user = current_user
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to :root
  end
end

private

def user_params
  params.fetch(:user, {}).permit(:email, phones_attributes: [:number])
end
