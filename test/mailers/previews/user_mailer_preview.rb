# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def confirm_email
	    UserMailer.with(user: User.first).confirm_email
	end
end
