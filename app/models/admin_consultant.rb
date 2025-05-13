class AdminConsultant < ApplicationRecord
	belongs_to :user
	has_many :consultant_admins
	# scope :profile_details, -> (id) {where(user_id: id).select(:branch_Name, :owner_Name, :phone_Number, :email, :gender, :location, :address)}
	
	def self.profile_details(user)
		obj = {}
		data = find_by(user_id: user.id)
		obj['branch_Name'] = data.branch_Name
		obj['owner_Name'] = data.owner_Name
		obj['phone_Number'] = data.phone_Number
		obj['email'] = data.email
		obj['gender'] = data.gender
		obj['location'] = data.location
		obj['address'] = data.address
		student = data.consultant_admins.includes(:user).map{|f| f.user.select{|g| g.role === 'student' } }
		educator = data.consultant_admins.includes(:user).map{|f| f.user.select{|g| g.role === 'educator' } }
		obj['Branch'] = data.consultant_admin_ids.length
		obj['Student'] =  student.flatten.length
		obj['Educator'] = educator.flatten.length

		obj
	end

end
