class PostsController < ApplicationController
	before_action :authenticate_request
	def index
		puts "-------i am here --------"
	end

	def getData
		p "-------------getdata"
		data = Post.all
		p data.inspect
		render json: data
	end


end
