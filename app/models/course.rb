class Course < ApplicationRecord
	belongs_to :sector
	has_many :course_entrolls
	has_many :course_labs
	has_many :course_sub_labs
	has_many :entrolled_students
	has_many :student_lab_codes
	has_one_attached :course_image
	has_many :student_course_entrollment

	def self.specific_course(id)
		user = User.find(id)
		p user
		if user.role == 'superadmin'
			belongs  = 0
		elsif  user.role == 'admin'
			belongs  = user.admin_consultant.id
		elsif user.role == "educator"
			belongs  = user.consultant_admins&.admin_consultant.id
		else
			belongs  = user.consultant_admins&.admin_consultant.id
		end
		p belongs
		p "--------------------belongsbelongs"
		return belongs
	end

    include Rails.application.routes.url_helpers  # Required for url_for

	def as_json(options = {})
	    super(options).merge({
	      course_image_url: course_image.attached? ? rails_blob_url(course_image, host: Rails.application.routes.default_url_options[:host]) : nil
	    })
	end


end
