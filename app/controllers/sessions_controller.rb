require Rails.root.join( "lib/sms_sender").to_s
class SessionsController < ApplicationController
  def new
  end

  def create
    @phone = UserPhone.find_by(number: phone_params[:number])
    @phone ||= UserPhone.create(phone_params)
    if @phone.valid?
      session[:phone] = @phone.number
      @phone.update_code
      SmsSender.new(@phone.number, @phone.code).send_sms
    else
      render(:new)
    end
  end

  def update
    phone = UserPhone.find_by(code: params[:code], number: session[:phone])
    if phone
      session[:user_id] = phone.user_id
      phone.update(code: nil)
      redirect_to :root
    else
      render :create
    end
  end

  def destroy
  end

  private

  def phone_params
    params.require(:user_phone).permit(:number, user_attributes: [:email])
  end

  def number
    @user ||= UserPhone.new(user_params)
  end
  helper_method :number
end
