class StudentDataCourseDetailsService
	  def self.studentDtetailsWithCourse(userid)
	    p userid
	    user = User.find(userid)
	    
	    data = check_course_progress(userid)
	    
	    p data
	    entrolled_course = data.map { |course| course["status"] }
	    inprogress_course = data.map { |course| course["status"] }.reject{|data| data == "Completed"}
	    completed_course = data.map { |course| course["status"] }.reject{|data| data == "InProgress"}
	    student = user.student_detail
	    student_details = {
	      "name" => "#{student.first_name} #{student.last_name}",
	      "image" => user.image.attached? ? Rails.application.routes.url_helpers.url_for(user.image) : 'a0.jpg',
	      "gender" => student.gender.present? ? student.gender : 'none',
	      "dob" => student.dob.present? ? student.dob : 'none',
	      "email" => user.email.present? ? user.email : 'none',
	      "phone_number" => student.phone_number.present? ? student.phone_number : 'none',
	      "location" => student.location.present? ? student.location : 'none',
	      "Active" => "Active Student",
	      "courses" =>  data,
	      "Entrolled_course" => entrolled_course.length,
	      "Inprogress_course" => inprogress_course.length,
	      "Completed_course" => completed_course.length
	    }

	    student_details
	  end



  	def self.check_course_progress(userid)
	  user = User.find(userid)
	  enrolled_course_ids = user.student_course_entrollment.pluck(:course_id)
	  courses = Course.where(id: enrolled_course_ids).pluck(:id, :name).to_h
	  course_labs = {}
	  untaken_labs = courses.each_with_object({}) do |(k, v), hash|
	    hash[k] = Course.find(k).course_lab_ids
	    course_labs[k] = Course.find(k).course_labs.pluck(:id, :name).to_h
	  end
	  array = []
	  goup_course = user.student_lab_entrollments.group_by(&:course_id).each_with_object({}) do |(course_id, studentLabData), hash|
	    # Convert each record to a hash and merge the lab name
	    studentLabData = studentLabData.map do |data|
	      lab_name = course_labs[course_id][data.course_lab_id] || "Unknown Lab"
	      data.attributes.merge("name" => lab_name)
	    end

	    obj = {}
	    obj[course_id] = {}
	    obj[course_id]["name"] = courses[course_id]
	    remaining = untaken_labs[course_id] - studentLabData.pluck("course_lab_id")
	    all_lab_status = studentLabData.pluck("status").include?("InProgress")
	    obj[course_id]["status"] = (remaining.empty? && !all_lab_status) ? "Completed" : "InProgress"
	    obj[course_id]["color"] = obj[course_id]["status"] == "Completed" ? "text-success" : "text-warning"
	    obj[course_id]["labs"] = studentLabData
	    array << obj[course_id]
	  end
	  array
	end

end

 # [
#  {
#   name: "Web Development",
#   status: "Completed",
#   color: "text-success" or "text-warning",
#   labs: ["HTML Basics", "CSS Fundamentals", "JavaScript Essentials", "React Basics", "Node.js Intro", "Express.js", "MongoDB", "APIs", "Deployment", "Project Work"]
# },


# ]

