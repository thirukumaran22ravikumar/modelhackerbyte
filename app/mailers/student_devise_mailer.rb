class StudentDeviseMailer < ApplicationMailer

	default from: 'thiruhealthguru22@gmail.com'

	def invite_student(user, token)
		@user = user
		@token = token
		@set_password_url = "http://localhost:5173/set_password?reset_password_token=#{@token}"

		mail(to: @user.email, subject: 'Welcome — Set your password')
	end
end
