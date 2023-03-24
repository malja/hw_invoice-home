module ValidatorHelper
	# We are not using URI::MailTo::EMAIL_REGEXP, because it allows for (IMHO) invalid emails to pass the tests
	# For example: test@domain is valid email.
	EMAIL_REGEX = /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,10})+\z/
end