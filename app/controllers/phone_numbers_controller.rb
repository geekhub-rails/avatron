class PhoneNumbersController < ApplicationController
  def create
    @phone_number = current_user.phones.create(phone_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def phone_params
    params.require(:user_phone).permit(:number)
  end
end
