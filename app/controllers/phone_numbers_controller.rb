class PhoneNumbersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @phone_number = current_user.phones.new(phone_params)
    if @phone_number.valid?
      @phone_number.save
      SmsSender.new(@phone_number, @phone_number.code).send_sms
    else
      render(:new)
    end
  end

  def updates
    @phones = current_user.phones.order(:id)
    #@phones = confirmed_phones
    return unless user_phone
    user_phone.update(phone_params)
  end

  def update
    @phone_number = UserPhone.find_by(phone_params)
    if @phone_number
      @phone_number.update(code: nil)
      redirect_to :profile
    else
    # current_user.phones.last.destroy
    # render :new
    # redirect_to :profile
    end
  end

  def confirm_number
    @phone_number = UserPhone.find_by(id: params[:id])
    @phone_number.generate_code
    SmsSender.new(@phone_number, @phone_number.code).send_sms
    render :confirm_number
  end

  def destroy
    @phone_number = current_user.phones.find_by(id: params[:id])
    @phone_number.destroy
  end

  def phone_params
    params.require(:user_phone).permit(:number, :avatar_id, :code)
  end

  def user_phone
    @user_phone ||= current_user.phones.find_by(id: params.dig(:user_phone, :id))
  end
end
