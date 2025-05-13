class StudentLabCode < ApplicationRecord
	belongs_to	:user
	belongs_to :course_lab
	belongs_to :course_sub_lab
	belongs_to :course
	belongs_to :assign_student_lab

	def self.last_version_lab(userId)
		data = where(user_id: userId)
		p "-------------------------------------------------"
		data.each_with_object({})do |(key, value), obj|
			p key
			p value
			p "-----------"
			# obj[key] = value
		end

	end
end
