class UserMailer < ApplicationMailer
	default from: 'noreply@avatron.com'

	def confirm_email(user)
		@user = user
		mail(to: @user.new_email, subject: 'New email confirmation')
	end

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Email confirmation')
	end
end
