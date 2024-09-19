class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /resource/sign_in
  def create
    # Find the user by email
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless resource

    # Check if the password is valid
    if resource.valid_password?(params[:password])
      # Sign in the user
      sign_in(resource_name, resource)
      render json: { user: {email:resource[:email],role: resource[:role],username: resource[:username]}, message: "Successfully logged in", status: :ok }
    else
      puts "Calling warden.custom_failure!"
      warden.custom_failure!
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end



  # DELETE /users/sign_out
  # def destroy
  #   if user_signed_in?
  #     sign_out(current_user)
  #     render json: { message: "Successfully logged out", status: :ok }
  #   else
  #     render json: { error: "User not signed in" }, status: :unauthorized
  #   end
  # rescue StandardError => e
  #   render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
  # end
  private

  # Method for handling invalid login attempts
  def invalid_login_attempt
    render json: { error: "Invalid email or password" }, status: :unauthorized
  end
end
