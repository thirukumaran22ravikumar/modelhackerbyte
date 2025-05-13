class CourseTittle < ApplicationRecord
	belongs_to :sector
	# serialize :select_course, Array

	def self.tittle_with_course(id)
		obj = {}
		data =  where(show_login: true,belongs: id).each do |data|
			obj[data.id] = {:data => Course.where(id: data.select_course), :name => data.name}
		end
		obj
	end

end
