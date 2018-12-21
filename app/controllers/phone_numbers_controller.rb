class PhoneNumbersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @phone_number = current_user.phones.create(phone_params)
    if @phone_number.valid?
      @phone_number.update_code
      SmsSender.new(@phone_number, @phone_number.code).send_sms
    else
      current_user.phones.last.destroy
      render(:new)
    end
  end

  def update
    @phones = current_user.phones.order(:id)
    return unless user_phone
    user_phone.update(phone_params)
    @phone_number = UserPhone.find_by(code: params[:code])
    if @phone_number
      @phone_number.update(code: nil)
      redirect_to :profile
    else
      current_user.phones.last.destroy
      render :js => "alert('Wrong confirmation code'), location.reload();"
      #render :new
      #redirect_to :profile
    end
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
