class StudentDetailsController < ApplicationController
	before_action :authenticate_request

	# def create
	# 	sanitized_email = student_details_params[:email].to_s.strip.downcase
	# 	unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
	# 	    return render json: { success: false, error: "Invalid email format" }, status: 422
	# 	end

	# 	user = User.find_by(email: student_details_params[:email])
	# 	unless user.present?
	# 		# p student_details_params
	# 		# p "---------@student_details----------------"
	# 		# p student_details_params[:belongs_user_id]
	# 		new_user = User.create(email: sanitized_email,username: student_details_params[:first_name],  role: student_details_params[:role], password: 'Default@123', password_confirmation: 'Default@123',belongs_user_id: student_details_params[:belongs_user_id]) 
			
	# 		studentDetails = StudentDetail.create(first_name: student_details_params[:first_name],last_name: student_details_params[:last_name],gender: student_details_params[:gender],dob: student_details_params[:dob],phone_number: student_details_params[:phone_number],location: student_details_params[:location],user_id: new_user.id)
			
	# 	else
	# 		return render json: { success: false, error: "Email Already Present" }, status: 422
	# 	end
	# end


	def create
		  p "--------------create_consultantAdmin"
		  # createAdmin = params[:createAdmin]
		  sanitized_email = student_details_params[:email].to_s.strip.downcase

		  unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
		    return render json: { success: false, error: "Invalid email format" }, status: 422
		  end

		  user = User.find_by(email: sanitized_email)
		  if user.present?
		    return render json: { success: false, error: "Email already exists" }, status: 422
		  end

		  # branch_admin = ConsultantAdmin.find_by(branch_admin_id: createAdmin[:admin_id].to_i)

		  # ✅ Generate password ONCE and reuse it
		  generated_password = SecureRandom.hex(10)

		  new_user = User.create!(
		    email: sanitized_email,
		    username: student_details_params[:first_name],
		    role: student_details_params[:role],
		    password: generated_password,
		    password_confirmation: generated_password,
		    belongs_user_id: student_details_params[:belongs_user_id].to_i
		  )
		  studentDetails = StudentDetail.create(first_name: student_details_params[:first_name],last_name: student_details_params[:last_name],gender: student_details_params[:gender],dob: student_details_params[:dob],phone_number: student_details_params[:phone_number],location: student_details_params[:location],user_id: new_user.id)
		  # Generate reset token
		  token = new_user.send(:set_reset_password_token)

		  # Send custom email with token
		  StudentDeviseMailer.invite_student(new_user, token).deliver_later

		  render json: { success: true, data: new_user }, status: 200
	end




	def show

		puts params[:id].to_s
		p "----------------------------------------------------------------------------"

		user = User.where(role: 'student',belongs_user_id: params[:id].to_i).pluck(:username, :email)

		# profiles_with_users =  StudentDetail.where(user_id: user).pluck(:first_name,:email)
		data = user
		render json:{success: true,data: data},status: 200
	end


	def update
	  user = User.find(params[:id].to_i)
	  permitted_params = student_details_params.except("Entrolled", "Completed", "Pending" ,"email")
	  if user.student_detail.update(permitted_params)
	  	user.update(username: params[:createAdmin][:username])
	    render json: { message: "Admin Consultant updated successfully" }, status: :ok
	  else
	    render json: { error: user.admin_consultant.errors.full_messages }, status: :unprocessable_entity
	  end
	end


	private
	def student_details_params
		@student_details = params.require(:createAdmin).permit(:first_name, :last_name,:gender,:phone_number,:email,:location,:role,:belongs_user_id)
	end
end
