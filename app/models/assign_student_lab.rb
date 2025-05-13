class AssignStudentLab < ApplicationRecord
	belongs_to	:user
	belongs_to :course_lab
	belongs_to :course_sub_lab
	belongs_to :course
	has_one :student_lab_codes
	after_create :create_entrolled_lab

	private

	def create_entrolled_lab
		
		exited_labs = StudentLabEntrollment.where(user_id: self.user_id ,course_lab_id: self.course_lab_id)
		unless exited_labs.present?
			StudentLabEntrollment.create(user_id: self.user_id ,course_id: self.course_id,course_lab_id: self.course_lab_id,status: "InProgress")
		else
			exited_labs.update(status: "InProgress")
		end


	end
end
