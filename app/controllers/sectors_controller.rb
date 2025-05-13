class SectorsController < ApplicationController
	before_action :authenticate_request
	def index
		data = Sector.all
		render json: {success: true, data: data,},status: 200
	end

	def create
		data = Sector.create(sector_params)
		render json:{success: true, data: data, },status: 200
	end


	def GetDataWithCourse
		data = Sector.sector_tittle_with_course
		render json:{success: true,data: data},status:200
	end


	private
	def sector_params
		new_sector = params.require(:newSector).permit(:name, :show_login)
	    # Ensure show_login is a boolean
	    new_sector[:show_login] = new_sector[:show_login].to_s.downcase == 'true'
	    new_sector
	end

end
