class AdminConsultantsController < ApplicationController
	before_action :authenticate_request
	def index
		admin_consultant = AdminConsultant.all.pluck(:branch_Name,:owner_Name,:phone_Number,:email,:gender,:location)
		if admin_consultant.present?
			data = admin_consultant
		else
			data = []
		end
		render json:{success: true,data: data},status: 200

	end
	# def create
	# 	p "----------------------i am created"
	# 	p params[:createAdmin]
	# 	p "---------"
	# 	sanitized_email = createAdmin[:email].to_s.strip.downcase
	# 	unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
	# 	    return render json: { success: false, error: "Invalid email format" }, status: 422
	# 	end
	# 	user = User.find_by(email: createAdmin[:email])
	# 	unless user.present?
	# 		new_user = User.create(email: sanitized_email, role: 'admin', password: 'Default@123', password_confirmation: 'Default@123',username: createAdmin[:owner_Name]) 
	# 		data = AdminConsultant.create(createAdmin)
	# 		data.update(user_id: new_user.id)
	# 	end
		
	# 	render json:{success: true, data: data},status: 200
	# end





	def create
	  p "-----uuuuuuuuu---------create_consultantAdmin"
	 
	  sanitized_email = createAdmin[:email].to_s.strip.downcase

	  unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
	  	p "oooijiogjgij-----------------------------------"
	    return render json: { success: false, error: "Invalid email format" }, status: 422
	  end

	  user = User.find_by(email: sanitized_email)
	  if user.present?
	    return render json: { success: false, error: "Email already exists" }, status: 422
	  end

	  # ✅ Generate password ONCE and reuse it
	  generated_password = SecureRandom.hex(10)
	  p "000000000000000000----------------00000000000000000000000000000---------00000000000000000"
	  new_user = User.create!(
	    email: sanitized_email,
	    username: createAdmin[:owner_Name],
	    role: 'admin',
	    password: generated_password,
	    password_confirmation: generated_password,
	  )
	  # data = AdminConsultant.create(createAdmin)
	  # data.update(user_id: new_user.id)

	   data = AdminConsultant.create!(create_admin_params.merge(user_id: new_user.id))
	  # Generate reset token
	  token = new_user.send(:set_reset_password_token)
	  p "0000000000000000000000000000000000000000000000000000000000000000"
	  # Send custom email with token
	  AdminDeviseMailer.invite_admin(new_user, token).deliver_later

	  render json: { success: true, data: new_user }, status: 200
	end



















	def show
		p " iam show "
	end


	# def create_consultantAdmin
	# 	p "--------------create_consultantAdmin"
	# 	createAdmin = params[:createAdmin]
	# 	sanitized_email = createAdmin[:Email].to_s.strip.downcase
	# 	unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
	# 	    return render json: { success: false, error: "Invalid email format" }, status: 422
	# 	end

	# 	user = User.find_by(email: createAdmin[:Email])
	# 	unless user.present?
	# 		# branch_admin = ConsultantAdmin.find_by(branch_admin_id: createAdmin[:admin_id].to_i)

	# 		new_user = User.create(email: sanitized_email,username: createAdmin[:name],  role: 'educator', password: 'Default@123', password_confirmation: 'Default@123',belongs_user_id: createAdmin[:admin_id].to_i) 
	# 	else
	# 		return render json: { success: false, error: "Email Already Present" }, status: 422
	# 	end
	# 	render json:{success: true, data: new_user},status: 200
	# end

	def create_consultantAdmin
	  p "--------------create_consultantAdmin"
	  createAdmin = params[:createAdmin]
	  sanitized_email = createAdmin[:Email].to_s.strip.downcase

	  unless sanitized_email.match?(/\A[^@\s]+@[^@\s]+\z/)
	    return render json: { success: false, error: "Invalid email format" }, status: 422
	  end

	  user = User.find_by(email: sanitized_email)
	  if user.present?
	    return render json: { success: false, error: "Email already exists" }, status: 422
	  end

	  branch_admin = ConsultantAdmin.find_by(branch_admin_id: createAdmin[:admin_id].to_i)

	  # ✅ Generate password ONCE and reuse it
	  generated_password = SecureRandom.hex(10)

	  new_user = User.create!(
	    email: sanitized_email,
	    username: createAdmin[:name],
	    role: 'educator',
	    password: generated_password,
	    password_confirmation: generated_password,
	    belongs_user_id: createAdmin[:admin_id].to_i
	  )

	  # Generate reset token
	  token = new_user.send(:set_reset_password_token)

	  # Send custom email with token
	  EducatorDeviseMailer.invite_educator(new_user, token).deliver_later

	  render json: { success: true, data: new_user }, status: 200
	end



	def consultant_admins_datas
		p "i am coing consultant_admins_datas"
		data = User.where(belongs_user_id: params[:id],role: "educator").all.pluck(:username,:email)
		data = data || []
		p data
		render json:{success: true, data: data},status: 200
	end

	def update
	  user = User.find(params[:id].to_i)
	  permitted_params = createAdmin.except("Branch", "Student", "Educator")
	  if user.admin_consultant.update(permitted_params)
	  	user.update(username: createAdmin[:owner_Name])
	    render json: { message: "Admin Consultant updated successfully" }, status: :ok
	  else
	    render json: { error: user.admin_consultant.errors.full_messages }, status: :unprocessable_entity
	  end
	end

	def get_branch_id
		p params[:id]
		belong_to_ids = User.get_current_id(params[:id].to_i)
		p belong_to_ids
		p "--------------------------------------------------------gggggggggggggggggg-----------------------------------gggg--------------------"
		render json:{success: true, data: belong_to_ids},status: 200
	end


	private
	 def createAdmin
	 	params.require(:createAdmin).permit(:branch_Name,:owner_Name,:phone_Number,:email,:gender,:location,:address)
	 end



	def create_admin_params
  		params.require(:createAdmin).permit(:branch_Name, :owner_Name, :phone_Number, :email, :gender, :location, :address)
	end
end
