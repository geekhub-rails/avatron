require Rails.root.join("lib/sms_sender").to_s
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
      binding.pry
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
    session[:user_id] = nil  
    redirect_to :root
  end

  private

  def phone_params
    params.fetch(:user_phone, {}).permit(:number, user_attributes: [:email])
  end

  def number
    @phone ||= UserPhone.new(params['user_phone'])
  end
  helper_method :number
end
