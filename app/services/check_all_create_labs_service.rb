class CheckAllCreateLabsService
	include Rails.application.routes.url_helpers

	def self.create_methord
		puts "--------1---------"
		 course1 = Course.create(name: "Ruby_one",language_id: 12,show_login: true )
		 course2 = Course.create(name: "java_one",language_id: 21,show_login: false )
		 puts "course1"+course1.inspect

		 puts "--------2--------"

		lab1 = course1.course_labs.create(name: "ruby1",language_id: 12,description: "gvycg gfcgc ",couse_point: 50,difficulty_level: "easy")
		lab2 = course2.course_labs.create(name: "java1",language_id: 21,description: "gvycg gfcgc ",couse_point: 45,difficulty_level: "hard")

		puts "lab1"+lab1.inspect

		puts "--------3--------"

		
		sub_lab1 = lab1.course_sub_labs.create(name: "rubylab1" ,sub_lab_data: "print thiru",sub_lab_initial_code: "def methord puts 'thiru' end",correct_option: "thiru",embedded_url: "https://youbute.com",lab_type: 'labs')

		sub_lab2 =  lab2.course_sub_labs.create(name: "javalab1" ,sub_lab_data: "print thiru",sub_lab_initial_code: "def methord puts: 'thiru' ",correct_option: "thiru j",embedded_url: "https://youbute.com",lab_type: 'mcq')

		puts "sub_lab1"+lab1.inspect
	end


	def self.checkprogress(student_id,course_id)
  		course = Course.find(course_id)
  		completion_labs = Hash.new{|k,m| k[m]= [0,0]}
  		image =  course.course_image.attached? ? Rails.application.routes.url_helpers.url_for(course.course_image) : nil
  		data = course.course_labs.where(show_login: true)
  		assignlabData = AssignStudentLab.where(user_id: student_id,course_id: course_id)
  		sub_lab_status = assignlabData.group_by(&:course_lab_id).each_with_object({}) do |(course_lab_id, assignLabs),hash|
  			seleted = assignLabs.select do |subLab| 
  				subLab[:status] == 'InProgress'  
  				if subLab[:status] == 'InProgress'  
  					completion_labs[course_lab_id][0] = subLab[:version]
  					completion_labs[course_lab_id][1] = completion_labs[course_lab_id][1] += 1
  				end
  			end
  			hash[course_lab_id] = seleted.empty? ? "Completed" : "InProgress"
  		end
  		if sub_lab_status.values.present?
  			completed_data = sub_lab_status.select{|k,v| v == "Completed"}
  			completed_course = completed_data.keys
  			 datas = StudentLabEntrollment.where(user_id: student_id,course_id: course_id,course_lab_id: completed_course,status: "InProgress" )
  			 datas.each do |entrollLab|
  			 	entrollLab.update(status: "Completed")
  			 end
  		end

  		new_data = Hash.new{|j,m| j[m] = Hash.new{}}
  		new_array = []
  		data.each do |subLab|
  			new_data[subLab.id]["id"] = subLab.id
  			new_data[subLab.id]["name"] = subLab.name
  			new_data[subLab.id]["course_id"] = subLab.course_id
  			new_data[subLab.id]["language_id"] = subLab.language_id
  			new_data[subLab.id]["lab_point"] = subLab.lab_point
  			new_data[subLab.id]["difficulty_level"] = subLab.difficulty_level
  			new_data[subLab.id]["course_image"] = image
  			if sub_lab_status[subLab.id].present?
  				new_data[subLab.id]["percentage"] = sub_lab_status[subLab.id] == "InProgress" ?  precentage_methord(completion_labs,subLab.id) : "100.0"
  			else
  				new_data[subLab.id]["percentage"] = "0.0"
  			end
  			
  			new_data[subLab.id]["status"] = sub_lab_status[subLab.id].present? ? sub_lab_status[subLab.id] : "Not started"
  			
  			new_array << new_data[subLab.id]
  		end
  		entrollment = StudentCourseEntrollment.where(user_id: student_id,course_id: course_id,unlock: true).present? ? true : false
  		return [new_array,entrollment]
	end


	def self.precentage_methord(completion_labs,lab_id)
		labs = CourseLab.find(lab_id.to_i)
		count = (labs.course_sub_labs.length - completion_labs[lab_id.to_i][1])
		if count == 0
			percentage = 0.0
			return percentage.to_s
		else
			percentage = ((completion_labs[lab_id.to_i][1].to_f)/labs.course_sub_labs.length.to_f)*100.to_f
			return percentage.to_s
		end
	end

	def self.get_subLab_student(lab_id,user_id)
		courseLabs = CourseLab.find(lab_id)
		assignStudentVersion = AssignStudentLab.where(user_id: user_id,course_lab_id: lab_id,status: 'InProgress').first
		if assignStudentVersion.present?
			assignStudentLab = AssignStudentLab.where(user_id: user_id,course_lab_id: lab_id,version: assignStudentVersion.version).select{|data| data.status == 'Completed'}.pluck(:course_sub_lab_id)
			unless assignStudentLab.empty?
				data = courseLabs.course_sub_labs.reject{ |subLab| assignStudentLab.include?(subLab.id)}
			else
				data = courseLabs.course_sub_labs
			end
			return data
		else
			return courseLabs.course_sub_labs
		end
		
	end

end