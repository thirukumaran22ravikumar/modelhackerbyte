class ConsultantAdminsController < ApplicationController
	before_action :authenticate_request
	# before_action :editor_params , only: [:update]
	# def index
	# 	admin = AdminConsultant.find_by(user_id: params[:id].to_i)
	# 	data = admin.consultant_admins
	# 	render json: {success: true,data: data},status: 200

	# end

	# def create
	# 	consultant_admins_params = params[:createAdmin].permit!
	# 	admin = AdminConsultant.find_by(user_id: consultant_admins_params[:admin_consultant_id])
	# 	data = admin.consultant_admins.create(consultant_admins_params)
	# 	render json: {success:true,data: data},status:200
	# end

	

	# def uploadImage
	#     @post = AdminConsultant.find(1)
	    
	#     if @post.save
	#       render json: { post: @post, image_url: url_for(@post.image) }, status: :created
	#     else
	#       render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
	#     end
  	# end




	# private

	# def editor_params
	# 	@admin_consultant = ConsultantAdmin.find(params[:id].to_i)
	# end


 	before_action :set_consultant_admin, only: [:update, :upload_image, :getimage]

  	def index
	    admin = AdminConsultant.find_by(user_id: params[:id])
	    data = admin.consultant_admins.map do |consultant|
	      	{
		      id: consultant.id,
		      name: consultant.name,
		      location: consultant.location,
		      address: consultant.address,
		      branch_admin_id: consultant.branch_admin_id,
		      admin_consultant_id: consultant.admin_consultant_id,
		      created_at: consultant.created_at,
		      image_url: consultant.image.attached? ? url_for(consultant.image) : nil
		    }
	    end
	    render json: { success: true, data: data }, status: 200
  	end

  	def getimage 
  		data =  @consultant_admin.image.attached? ? url_for(@consultant_admin.image) : []
  		render json: {success: true, data: data},status: 200
  	end

  	def show
		admin = AdminConsultant.find_by(user_id: params[:id].to_i)
		consultant_admins = admin.consultant_admins
		data = consultant_admins.map do |consultant|
		    {
		      id: consultant.id,
		      name: consultant.name,
		      location: consultant.location,
		      address: consultant.address,
		      branch_admin_id: consultant.branch_admin_id,
		      admin_consultant_id: consultant.admin_consultant_id,
		      created_at: consultant.created_at,
		      image_url: consultant.image.attached? ? url_for(consultant.image) : nil
		    }
		end
		render json: {success: true,data: data},status: 200
	end

	def update
		@consultant_admin.update(consultant_admins_params)
	end

  	def create
	    consultant_admins_params = params.require(:createAdmin).permit(:name, :location, :address, :admin_consultant_id, :branch_admin_id, :image)
	    admin = AdminConsultant.find_by(user_id: consultant_admins_params[:admin_consultant_id])
	    
	    data = admin.consultant_admins.create(consultant_admins_params)
	    
	    render json: { success: true, data: data, image_url: url_for(data.image) }, status: 200
  	end

  	def upload_image
	    if params[:createAdmin][:image].present?
	      if @consultant_admin.image.attached?
		    @consultant_admin.image.purge 
		  end
	      @consultant_admin.image.attach(params[:createAdmin][:image])
	      if @consultant_admin.image.attached?
	        render json: { success: true, image_url: url_for(@consultant_admin.image) }, status: 200
	      else
	        render json: { success: false, error: "Image upload failed" }, status: 422
	      end
	    else
	      render json: { success: false, error: "No image provided" }, status: 400
	    end
  	end

	private

	def set_consultant_admin
	   @consultant_admin = ConsultantAdmin.find(params[:id].to_i)
	end

	def consultant_admins_params
		params.require(:createAdmin).permit(:name,:location,:address,:admin_consultant_id,:branch_admin_id)
	end




end
