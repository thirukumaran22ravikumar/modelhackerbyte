class CourseSubLab < ApplicationRecord
	belongs_to :course_lab
	has_many :student_lab_codes
	has_many :assign_student_labs
end
