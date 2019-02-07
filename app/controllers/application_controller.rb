require Rails.root.join( "lib/sms_sender").to_s
class ApplicationController < ActionController::Base
  layout 'application'

  def require_user
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user || User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def confirmed_phones
  	current_user.phones.each do |number|
  		number if number.confirmed?
  	end
  end
 end
