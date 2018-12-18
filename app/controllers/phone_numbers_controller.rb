class PhoneNumbersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @phone_number = current_user.phones.create(phone_params)
  end

  def edit
  end

  def update
    @phones = current_user.phones.order(:id)
    return unless user_phone
    user_phone.update(phone_params)
  end

  def destroy
    @phone_number = current_user.phones.find_by(id: params[:id])
    @phone_number.destroy
  end

  def phone_params
    params.require(:user_phone).permit(:number, :avatar_id)
  end

  def user_phone
    @user_phone ||= current_user.phones.find_by(id: params.dig(:user_phone, :id))
  end
end
