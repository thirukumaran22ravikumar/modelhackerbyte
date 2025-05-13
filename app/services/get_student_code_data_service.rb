class GetStudentCodeDataService

	def self.parse_code_data_string(code_data_string)
	  options = {}

	  # Match key-value pairs like "options1"=>"hh"
	  code_data_string.scan(/"?(options\d+)"?\s*=>\s*"([^"]+)"/).each do |key, value|
	    options[key] = value
	  end

	  [options] # return as an array of options
	end

	def self.get_review_lab_data(userId,courseId,lab_id)
		p userId
		p "--------------------------------userId"
		assign_student_labs = AssignStudentLab.where(user_id: userId, course_id: courseId, course_lab_id: lab_id).group_by(&:version).sort_by { |version, _| version }.last
			
		version, all_data = assign_student_labs
		all_version_ids = all_data.map{|data| data.id}
		course_sub_lab_id = all_data.map{|data| data.course_sub_lab_id}

		student_lab_codes = StudentLabCode.where(assign_student_lab_id: all_version_ids)
		course_sub_labs = CourseSubLab.where(id: course_sub_lab_id).group_by(&:id)
		review_code = {}

		merged_data = student_lab_codes.map do |data|
		  newdata = course_sub_labs[data.course_sub_lab_id][0]
		  # p newdata.inspect + "--------------------------------data"
		  	cleaned_code_data = []
		    if data.lab_type == 'MCQ' && data.code_data.is_a?(String)
		    	cleaned_code_data = self.parse_code_data_string(data.code_data)
		    else
		    	cleaned_code_data = []
		    end
		    data.attributes.merge(
		      initial_sub_lab_data: newdata.sub_lab_data,
		      option_data: cleaned_code_data,
		      admin_correct_answer: newdata.correct_option
		    )
		end
		p merged_data.to_s
		p "---------------------------------------------------------------------------------------------------------------"
		return merged_data

	end

	

end 