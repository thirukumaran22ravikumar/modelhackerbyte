class CourseLab < ApplicationRecord
	has_many :course_sub_labs
	# belongs_to :courses
	belongs_to :course
	has_many :student_lab_codes
	has_many :assign_student_labs
	has_many :entrolled_students
end
