
module LoginHelper
	def login(user)
		post login_path, params: {
			login: {
				email: user.email,
				password: user.password,
				password_confirmation: user.password
			}
		}
	end
end
