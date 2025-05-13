class CourseSubLabsController < ApplicationController
	before_action :authenticate_request
	def create
		puts "--------------------i a from createSubLab"+params[:newSubLab].to_s
		puts '------------------i a id'+params[:id].to_s
		raw = params[:newSubLab]
		show_url = raw['sublaburlshown'] == 'True' ? true : false
		lab = CourseLab.find(params[:id].to_i)
		data = lab.course_sub_labs.create(name: raw['sublabsname'],lab_type: raw['sublabtype'],show_url: false)

		render json: {success: true, data: data},status: 200
	end

	def show
		lab = CourseLab.find(params[:id].to_i)
		data = lab.course_sub_labs.all
		render json: {success: true, data: data},status: 200
	end

	def codeViewShow
		p "----------------------------codeViewShow"
		params[:courseId]
		course = Course.find(params[:courseId].to_i)
		if course.language_id == 0
			data = false
		else
			data = true
		end

		render json:{success: true,data: data},status: 200
	end

	def reviewCodeWindow
		p params[:id].to_s+"--------------------------user_id"
		p params[:lab_id].to_s+"------------------------lab"
		p params[:course_id].to_s+"---------------course"
		data = GetStudentCodeDataService.get_review_lab_data(params[:id].to_i,params[:course_id].to_i,params[:lab_id].to_i)
		render json:{success: true,data: data},status: 200

	end


end
