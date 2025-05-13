class StudentController < ApplicationController

	before_action :authenticate_request

	def index
		
		current_user = User.find(params[:id].to_i)
		p current_user.role
		if current_user.role == 'superadmin'
			user = User.where(role: 'student').all
			data_with_student = StudentDetail.includes(:user).where(user: user)
			data = data_with_student.pluck(:first_name,:last_name,:email,:belongs_user_id, :user_id)
		elsif  current_user.role == 'admin'
			get_consultant = current_user.admin_consultant
			consultant = get_consultant.consultant_admins.pluck(:id)
		  	user = User.where(role: 'student',belongs_user_id: consultant).all
		  	data_with_student = StudentDetail.includes(:user).where(user: user)
		  	data = []
		  	data_with_student.map do |student|
		    	data << [student.first_name, student.last_name, student.user.email, student.user.belongs_user_id, student.user.id]
		  	end
		elsif current_user.role == 'educator'

			user = User.where(role: 'student',belongs_user_id: current_user.belongs_user_id).all
			data_with_student = StudentDetail.includes(:user).where(user: user)
			data = data_with_student.pluck(:first_name,:last_name,:email,:belongs_user_id,:user_id)
		else
		end
		render json:{success: true,data: data},status: 200
	end

	def Assign_student_course
		course_ids = StudentCourseEntrollment.where(user_id: params[:id].to_i,unlock: true).pluck(:course_id)
		old_id = course_ids - params[:assignCourse]
		old_id.each { |data| course = StudentCourseEntrollment.where(course_id: data.to_i, user_id: params[:id].to_i).first; course.update(unlock: false) } if old_id.present?
		params[:assignCourse].each do |data|
			course = Course.find(data.to_i)
			already = StudentCourseEntrollment.where(course_id: data.to_i,user_id: params[:id].to_i).first
			if already.present?
				if already.unlock 
				else
					already.update(unlock: true)
				end
			else
				course.student_course_entrollment.create(user_id: params[:id].to_i,status: "InProgress",unlock: true)
			end
		end
	end

	def allCourseForSelectedStudent
		p params[:id].to_s
		course = StudentCourseEntrollment.where(user_id: params[:id].to_i,unlock: true).pluck(:course_id)
		selected_course_data = Course.where(id: course).where.not(belongs: 0)
		p selected_course_data
		render json:{success: true,data: selected_course_data},status: 200
	end

	def allCourseForSelectedAdminStudent
		p params[:id].to_s
		course = StudentCourseEntrollment.where(user_id: params[:id].to_i,unlock: true).pluck(:course_id)
		admin_selected_course_data = Course.where(id: course,belongs: 0)
		p admin_selected_course_data
		render json:{success: true,data: admin_selected_course_data},status: 200
	end


	def selectStudentCourseLab
		subLabdata = CheckAllCreateLabsService.get_subLab_student(params[:id].to_i,params[:user_id].to_i)
		render json: {success: true,data: subLabdata},status: 200
	end

	def savestudentCode
		raw = params[:allStudentLabData]
		getAssignstudentId = AssignStudentLab.where(status: "InProgress",course_sub_lab_id: raw['id']).first
		getAssignstudentId.update(end_time: Time.now,status: "Completed",score: params[:scores].to_i)
		
		get_language_id = CourseLab.find_by(id: raw['course_lab_id'])
		course = Course.find(get_language_id.course_id)
		course_sub_lab_id = CourseSubLab.find_by(id: raw['id'])
		user = User.find(params[:user_id].to_i)
		student_lab_code = StudentLabCode.new(
		    code_data: raw['sub_lab_initial_code'],
		    output_data: params[:output],
		    language_id: get_language_id.language_id,
		    course_sub_lab_id: course_sub_lab_id.id,
		    course_lab_id: get_language_id.id,
		    lab_type: raw["lab_type"],
		    assign_student_lab_id: getAssignstudentId.id,
		    course_id: course.id,
		    user_id: user.id,
		    version: getAssignstudentId.version.to_s,
		    take_time: '2'
		 )
		if student_lab_code.save
		  render json:{success:false,data: student_lab_code},status: 200
		end
	end

	def create_assign_student_labs
		course_lab = CourseLab.find(params[:courseId]['id'].to_i)
		if !course_lab.assign_student_labs.empty?

			# p "---present-------------------------------------"
			exited_sub_lab = course_lab.assign_student_labs
			exited_sub_lab_progress = course_lab.assign_student_labs.where(status: 'InProgress')
			if exited_sub_lab_progress
				exited_sub_lab.map do |data| 
					data['status'] 
					data.update(status: 'Completed')
				end
			end
			version = exited_sub_lab.group_by{|ver| ver.version}.sort_by{ |key, _| key }
			last_ver = version.last[0]+1

			course_lab.course_sub_labs.each do |d|
			  create_assign_sublab = AssignStudentLab.create(
			    user_id: params[:userId].to_i,
			    course_id: course_lab.course.id,
			    course_lab_id: params[:courseId]['id'].to_i,
			    course_sub_lab_id: d.id,
			    start_time: Time.now,
			    end_time: nil,
			    version: last_ver,
			    status: "InProgress"
			  )
			end
			# p "--------------------------exited_sub_lab-----------------------"
		else
			# p '---new'
			# p "--------"
			course_lab.course_sub_labs.each do |d|
			  create_assign_sublab = AssignStudentLab.create(
			    user_id: params[:userId].to_i,
			    course_id: course_lab.course.id,
			    course_lab_id: params[:courseId]['id'].to_i,
			    course_sub_lab_id: d.id,
			    start_time: Time.now,
			    end_time: nil,
			    version: 1,
			    status: "InProgress"
			  )

			  # unless create_assign_sublab.save
			  #   Rails.logger.error("Failed to save AssignStudentLab: #{create_assign_sublab.errors.full_messages}")
			  # end
			end
		end
	end

	def upload_image
		if params[:user][:image].present?
			@user = User.find(params[:id].to_i)
	      if @user.image.attached?
		    @user.image.purge 
		  end
	      @user.image.attach(params[:user][:image])
	      if @user.image.attached?
	      	p @user.image
	        render json: { success: true, image_url: url_for(@user.image) }, status: 200
	      else
	        render json: { success: false, error: "Image upload failed" }, status: 422
	      end
	    else
	      render json: { success: false, error: "No image provided" }, status: 400
	    end
	end

	def getimage 
		@user = User.find(params[:id].to_i)
		data = [@user.image.attached? ? url_for(@user.image) : 'a0.jpg',@user.cover_image.attached? ? url_for(@user.cover_image) : 'cover-01.png']
  		render json: {success: true,data: data}, status: 200
  	end

  	def upload_image_cover
  		if params[:user][:cover_image].present?
  		  @user = User.find(params[:id].to_i)
	      @user.cover_image.purge if @user.cover_image.attached? # Remove old image
	      @user.cover_image.attach(params[:user][:cover_image])
	      if @user.cover_image.attached?
	        render json: { success: true, image_url: url_for(@user.cover_image) }, status: 200
	      else
	        render json: { success: false, error: "Cover image upload failed" }, status: 422
	      end
	    else
	      render json: { success: false, error: "No cover image provided" }, status: 400
	    end
	end


	def get_student_center
		@user = User.find(params[:id].to_i)
		
		get_consultant = @user.consultant_admins
		data = [get_consultant.image.attached? ? url_for(get_consultant.image) : 'local', get_consultant.name.present? ? get_consultant.name : 'local' ]
	
		render json:{success: true,data: data},status: 200
	end


	def profile_details
		@user = User.find(params[:id].to_i)
		if @user.role == 'admin'
			data = AdminConsultant.profile_details(@user)
			p "-----------------"
			p data
		elsif @user.role == 'student'
			data = StudentDetail.profile_details(@user)
		elsif @user.role == 'educator'
			data = StudentDetail.profile_details(@user.id)
		elsif @user.role ==  'superadmin'
			data = []
		else

		end
		render json:{success: true, data: data},status: 200
	end

	def GetAllDataStudent
		p params[:id]
		if params[:id].present?
			data = StudentDataCourseDetailsService.studentDtetailsWithCourse(params[:id].to_i)
		else
			data = []
		end
		p data
		render json:{success: true, data: data},status: 200
	end



end
