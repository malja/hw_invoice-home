class UserMailer < ApplicationMailer
	def welcome_email(user)
		@user = user
		@url = 'https://address-book.malcak.cz/login'
		mail(to: @user.email, subject: 'Welcome to Address Book!', template_name: 'welcome_email', template_path: 'user_mailer')
	end

	def goodbye_email(user)
		@url = 'https://address-book.malcak.cz/login'
		mail(to: user.email, subject: 'Sad to see you go :(', template_name: 'goodbye_email', template_path: 'user_mailer')
	end
end
