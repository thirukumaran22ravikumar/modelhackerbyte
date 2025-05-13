class Sector < ApplicationRecord
	has_many :courses
	has_many :course_tittles

	def self.sector_tittle_with_course
		data = Sector.includes(:course_tittles)
             .where(course_tittles: { belongs: 0 })
        obj = {}
		data.each do |sector|
		  obj[sector.name] = sector.course_tittles.select(&:name) 
		end

		return obj || {}

	end
end
