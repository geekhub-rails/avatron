class PhoneNumbersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @phone_number = current_user.phones.create(phone_params)
  end

  def edit
  end

  def update
    current_user.phones.find_by(id: params['id']).avatar = Avatar.find_by_url(params['url'])

    @phones = current_user.phones
    @avatars = current_user.avatars
  end

  def destroy
  end

  def phone_params
    params.require(:user_phone).permit(:number)
  end
end
