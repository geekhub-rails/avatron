class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    @phone = UserPhone.find_by(number: phone_params[:number], code: nil)
    @phone ||= UserPhone.create(phone_params)
    if @phone.valid?
      session[:phone] = @phone.number
      @phone.generate_code
      @phone.save
      SmsSender.new(@phone.number, @phone.code).send_sms
      send_welcome_email unless phone_params[:user_attributes][:email].blank?
    else
      render(:new)
    end
  end

  def update
    @phone =  UserPhone.find_by(number: session[:phone])
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

  def resend_code
    @phone = UserPhone.find_by(number: session[:phone])
    SmsSender.new(@phone.number, @phone.code).send_sms
    render :create
  end

  private

  def phone_params
    params.fetch(:user_phone, {}).permit(:number, user_attributes: [:email])
  end

  def number
    @phone ||= UserPhone.new(params['user_phone'])
  end
  helper_method :number

  def user_params
    params.fetch(:user, {}).permit(:email, phones_attributes: [:number])
  end

  def send_welcome_email
    @user = User.find_by(email: phone_params[:user_attributes][:email])
    @user.set_confirmation_token
    @user.save
    UserMailer.welcome_email(@user).deliver_now unless @user.blank?
  end
end
