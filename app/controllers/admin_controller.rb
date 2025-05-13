class AdminController < ApplicationController

	before_action :authenticate_request

	# def createCourse
	# 	all_data = params[:newCourse]
	# 	sector = Sector.find_by(id: all_data['Sector'])
	# 	if sector
	# 	  course1 = sector.courses.create(
	# 	    name: all_data['coursename'],
	# 	    language_id: all_data['selectlanguage'].to_i,
	# 	    show_login: all_data['showcourse'] == "True" ? 1 : 0
	# 	  )
	# 	  if course1.persisted?
	# 	    render json: { success: true, course: course1 }, status: :created
	# 	  else
	# 	    render json: { success: false, errors: course1.errors.full_messages }, status: :unprocessable_entity
	# 	  end
	# 	else
	# 	  render json: { success: false, error: "Sector not found" }, status: :not_found
	# 	end
	# end

	# def getCourse
	# 	data = Course.all
	# 	puts "---------------ijbuhgu"
	# 	render json: {success: true, data: data, },status: 200
	# end
	# def getallLab
	# 	puts params[:id].to_s+"-------------------------jhbhb"
	# 	course = Course.find(params[:id])
	# 	data = course.course_labs.all
	# 	puts   data.inspect
	# 	render json: {success: true, data: data, },status: 200
	# end

	def getSubAllLab
		lab = CourseLab.find(params[:id].to_i)
		data = lab.course_sub_labs.all
		render json: {success: true, data: data},status: 200
	end

	# def createSubLab
	# 	puts "--------------------i a from createSubLab"+params[:newSubLab].to_s
	# 	puts '------------------i a id'+params[:id].to_s
	# 	raw = params[:newSubLab]
	# 	show_url = raw['sublaburlshown'] == 'True' ? true : false
	# 	lab = CourseLab.find(params[:id].to_i)
	# 	data = lab.course_sub_labs.create(name: raw['sublabsname'],embedded_url: raw['sublabEmbadded'],lab_type: raw['sublabtype'],show_url: show_url)

	# 	render json: {success: true, data: data},status: 200
	# end

	def createSubCourse
		puts "---------------------i am for createSubCourse"
		puts params[:subCourseid].to_s+"---------------------------tttt---------"
		lab_data = params[:newLab]
		get_couse = Course.find(params[:subCourseid].to_i)
		get_couse.course_labs.create(name: lab_data['labsname'],language_id: params[:languageId],description: lab_data[:labsdescription],lab_point: lab_data[:labspoint],difficulty_level: lab_data[:labsdifficulty],order: lab_data[:labsorder],show_login: lab_data[:labslogin])
		puts get_couse.inspect
		render json: {success: true, data: get_couse,},status: 200

	end
	DEMO_TABLE = [
    { id: 1, name: 'Alice', age: 25, city: 'New York' },
    { id: 2, name: 'Bob', age: 30, city: 'Los Angeles' },
    { id: 3, name: 'Charlie', age: 22, city: 'Chicago' }
  	]

	def execute_query
	    query = params[:query].strip.downcase

	    # Restrict queries to SELECT statements only on demo_table
	    if query.start_with?('select') && query.include?('demo_table')
	      # Simulate result based on query logic
	      # You can parse and simulate SQL queries here (for simplicity, we'll only allow basic SELECT queries)
	      if query.include?('select * from demo_table')
	        result = DEMO_TABLE
	      else
	        result = [] # For unsupported queries, return empty
	      end
	      if query.include?('where city = "New York"')
			  result = DEMO_TABLE.select { |row| row[:city] == 'New York' }
		  end

	      render json: { result: result }
	    else
	      render json: { error: 'Only SELECT queries on demo_table are allowed' }, status: :unprocessable_entity
	    end
  	end


  	def get_codeWindow_data
  		p "i am coming in get_codeWindow_data"
  		p params[:id].to_s+"-------------uuu---------"
  		data = CourseSubLab.find(params[:id].to_i)
  		puts data.inspect+"--------yy--------------"
  		lab = CourseLab.find_by(id: data.course_lab_id.to_i)
  		enable_html = [20, 30, 100].include?(lab.language_id)
  		enhanced_data = data.attributes.merge(language: lab.language_id,enable_console: enable_html, show_url: data.show_url .to_s)
  		render json: {success: true, data: enhanced_data},status: 200

  	end

  	def UpadteSubLabData
  		puts params[:id].to_s
  		code = params[:currentsublabvalue]['sub_lab_initial_code'].to_s
  		answer = params[:currentsublabvalue]['correct_option'].to_s
  		description = params[:currentsublabvalue]['sub_lab_data'].to_s
  		lab_type = params[:currentsublabvalue]['lab_type'].to_s
  		embedded_url = params[:currentsublabvalue]['embedded_url']
  		show_url = params[:currentsublabvalue]['show_url'] == 'false' ? false : true

  		data = CourseSubLab.find(params[:id].to_i)
  		if lab_type == 'LAB'
  			data.update(correct_option: answer,sub_lab_initial_code: code,sub_lab_data: description, embedded_url: embedded_url,show_url: show_url )
  		else
  			code = code.to_unsafe_h if code.is_a?(ActionController::Parameters)		
  			data.update(correct_option: answer,sub_lab_initial_code: code,sub_lab_data: description, embedded_url: embedded_url,show_url: show_url )	
  		end

  		render json:{success: true,data: ''},status: 200
  	end

  	def createTittle
  		puts "----------createTittle"
  		p params[:newCategory]['Sector']
  		sector = Sector.find(params[:newCategory]['Sector'].to_i)
  		show = params[:newCategory]['showcategory'] == 'True' ? true: false
  		p show
  		user = Course.specific_course(params[:newCategory]['userId'].to_i)
  		data = sector.course_tittles.create(name: params[:newCategory]['name'],show_login: show,select_course: params[:newCategory]['selectedCourse'],belongs: user)
  		render json: {success: true, data: data},status: 200

  	end

  	def updateTittleCourse
  		tittle = CourseTittle.find(params[:id].to_i)
  		data = tittle.update(select_course: params['selectedCourses'])
  		render json: {success: true, data: data},status: 200

  	end

  	def updateTittleName
  		tittle = CourseTittle.find(params[:id].to_i)
  		data = tittle.update(name: params['editValue'])
  		render json: {success: true, data: data},status: 200
  	end

  	def removeCourseTittle
  		tittle = CourseTittle.find(params[:id].to_i)
  		p tittle.select_course
  		remove_value = tittle.select_course.reject { |num| num == params[:data][:id].to_i }
  		data = tittle.update(select_course: remove_value)
  		render json: {success: true, data: data},status: 200
  	end

  	def deleteTittle
  		p "-----------deleteTittle-------------------------"
  		p params[:id].to_s
  		tittle = CourseTittle.find(params[:id].to_i)
  		tittle.destroy
  		render json: {success: true, data: "data"},status: 200

  	end





  	def getTittleTable 
  		belongs = Course.specific_course(params[:id])
  		data = CourseTittle.where(show_login: true,belongs: belongs).all
  		puts data.inspect

  		p "---------------------------------------------------------------------uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu----------------------------"
  		render json: {success: true, data: data},status: 200
  	end

  	def getStudentSelectCourse
  		datas = CheckAllCreateLabsService.checkprogress(params[:student_id].to_i,params[:id].to_i)
  		render json: {success: true, data: datas},status: 200
  	end


end
