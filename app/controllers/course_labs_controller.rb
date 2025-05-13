class CourseLabsController < ApplicationController
	before_action :authenticate_request
	def create
		puts "---------------------i am for createSubCourse  controller"
		puts params[:subCourseid].to_s+"---------------------------tttt---------"
		lab_data = params[:newLab]
		get_couse = Course.find(params[:subCourseid].to_i)
		get_couse.course_labs.create(name: lab_data['labsname'],language_id: params[:languageId],description: lab_data[:labsdescription],lab_point: lab_data[:labspoint],difficulty_level: lab_data[:labsdifficulty],order: lab_data[:labsorder],show_login: lab_data[:labslogin] == "True" ? 1 : 0)

		render json: {success: true, data: get_couse,},status: 200

	end

	def update
		p "----------------i am coming "
		lab = CourseLab.find(params[:id].to_i)
		labdata = params[:newLab]
		lab.update(name: labdata['labsname'],description: labdata[:labsdescription],lab_point: labdata[:labspoint],difficulty_level: labdata[:labsdifficulty],order: labdata[:labsorder],show_login: labdata[:labslogin] == "True" ? 1 : 0)
		render json: {success: true, data: lab},status: 200
	end


	def show
		puts params[:id].to_s+"-------------------------jhbhb"
		course = Course.find(params[:id])
		image =  course.course_image.attached? ?  url_for(course.course_image) : nil

		data = course.course_labs.map do |lab|
	    	lab.as_json.merge({ image_url: image })
	  	end
		render json: {success: true, data: data, },status: 200
	end


	def arrange_course
		p " enter -----------------------arrange---------"
		user = Course.specific_course(params[:userId].to_i)
		data = CourseTittle.tittle_with_course(user)
		render json:{success:true, data: data},status: 200
	end
end
