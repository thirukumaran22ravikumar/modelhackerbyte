class ConsultantAdmin < ApplicationRecord
	belongs_to :admin_consultant
	has_one_attached :image
	has_many :user , class_name: "User" ,foreign_key: "belongs_user_id"
	# has_many :user
	scope :get_all_branch, -> (user_id) { where(branch_admin_id: user_id) }

end
