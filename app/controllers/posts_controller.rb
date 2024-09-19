class PostsController < ApplicationController

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
