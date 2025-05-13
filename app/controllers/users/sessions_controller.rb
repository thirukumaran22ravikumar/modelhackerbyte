class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :authenticate_request, only: [:create]


  # POST /resource/sign_in
  # def create
  #   # Find the user by email
  #   resource = User.find_for_database_authentication(email: params[:email])
  #   return invalid_login_attempt unless resource

  #   # Check if the password is valid
  #   if resource.valid_password?(params[:password])
  #     # Sign in the user
  #     sign_in(resource_name, resource)
  #     puts resource.inspect
  #     render json: { user: {email:resource[:email],role: resource[:role],username: resource[:username],user_id: resource[:id] }, message: "Successfully logged in", status: :ok }
  #   else
  #     warden.custom_failure!
  #     render json: { error: "Invalid email or password" }, status: :unauthorized
  #   end
  # end

  def create
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:password])
      sign_in(resource_name, user)
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        token: token,
        user: {
          email: user.email,
          role: user.role,
          username: user.username,
          user_id: user.id
        },
        message: "Successfully logged in"
      }, status: :ok
    else
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
