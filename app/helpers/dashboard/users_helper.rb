module Dashboard::UsersHelper
	def user_params
		params.require(:user).permit(:email, roles: [])
	end
end
