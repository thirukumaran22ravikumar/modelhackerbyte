class StudentDetail < ApplicationRecord
	belongs_to :user
	# scope :profile_details, -> (id) {where(user_id: id).select(:first_name, :last_name, :phone_Number, :dob, :gender, :location, :course_details)}

	def self.profile_details(user)
		obj = {}
		data = find_by(user_id: user.id)
		obj['first_name'] = data.first_name
		obj['last_name'] = data.last_name
		obj['phone_number'] = data.phone_number
		obj['email'] = user.email
		obj['gender'] = data.gender
		obj['dob'] = data.dob
		obj['location'] = data.location
		obj['username'] = user.username
		# student = data.consultant_admins.includes(:user).map{|f| f.user.select{|g| g.role === 'student' } }
		# educator = data.consultant_admins.includes(:user).map{|f| f.user.select{|g| g.role === 'educator' } }
		obj['Entrolled'] = 1
		obj['Completed'] =  0
		obj['Pending'] = 1

		obj
	end


end
