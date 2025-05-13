class StudentLabEntrollment < ApplicationRecord
	belongs_to :user
	belongs_to :course_lab
	belongs_to :course
end
