class CoursesController < ApplicationController
	before_action :authenticate_request
	
	def create
		all_data = params[:newCourse]
		p " i am create ======"
		p all_data
		belongs  = Course.specific_course(all_data["userId"].to_i)
		sector = Sector.find_by(id: all_data['Sector'])
		if sector
		  course1 = sector.courses.create(
		    name: all_data['coursename'],
		    language_id: all_data['selectlanguage'].to_i,
		    show_login: all_data['showcourse'] == "True" ? 1 : 0,
		    belongs: belongs
		  )
		  course1.course_image.attach(all_data[:course_image]) if all_data[:course_image].present?
		  if course1.persisted?
		    render json: { success: true, course: course1 }, status: :created
		  else
		    render json: { success: false, errors: course1.errors.full_messages }, status: :unprocessable_entity
		  end
		else
		  render json: { success: false, error: "Sector not found" }, status: :not_found
		end
	end

	def update
		p "----------------------------"
		all_data = params[:newCourse]
		course = Course.find(params[:id].to_i)
		if all_data[:course_image].present?			
			course.course_image.purge if course.course_image.attached?
			course.course_image.attach(all_data[:course_image]) 
		end
		
		course.update(name: all_data['coursename'],language_id: all_data['selectlanguage'].to_i,show_login: all_data['showcourse'] == "True" ? 1 : 0,sector_id: all_data[:Sector])
		data = Course.all
		render json: {success: true, data: data, },status: 200

	end

	def destroy
		
	end


	def show
		data = Course.all
		puts data.inspect
		p "-----------------------------------------------------==================================================================="
		render json: {success: true, data: data, },status: 200
	end

	def getCourseData
		p "-----------------------------------getCorseData"
		p params[:userId].to_s
		user = Course.specific_course(params[:userId].to_i)
		data = Course.where(belongs: user, show_login: true)
		p "---------------------data-----------------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		puts data
		render json: {success: true, data: data, },status: 200
	end

	def entroll_course
		user = User.find(params[:userId].to_i)
		data = user.student_course_entrollment.create(course_id: params[:CourseId].to_i,status: "InProgress",unlock: true)
		render json:{success: true,data: data.present?,},status: 200
	end


	# def check_entrollment

	# 	kkkkk
	# end
	 def change_student_course
	 	user = User.find(params[:id].to_i)
	 	if user.role == 'superadmin'
	 		data = ConsultantAdmin.all
	 	else
	 		data = ConsultantAdmin.get_all_branch(user.id)
	 	end
	 	render json:{success: true,data: data},status: 200

	end

	def changed_course_student
		branch = params[:changeBranch]
		user = User.find(branch[:userId].to_i)
		user.update(belongs_user_id: branch[:course_id].to_i) if branch[:course_id]
		render json:{success: true,data: user},status: 200
	end




	private

	  # def set_series
	  #   @series = Series.find_by(id: params[:id])
	  #   unless @series
	  #     render json: { error: 'Series not found' }, status: :not_found
	  #   end
	  # end

	def new_course_params
		params.require(:series).permit(:name, :imageUrl, :comment, :likeCount)
	end
end
