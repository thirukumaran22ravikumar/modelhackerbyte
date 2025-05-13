class ApplicationController < ActionController::API
  before_action :authenticate_request, unless: :devise_controller?


  private

  # def authenticate_request
  #   p "-===================================================================================="
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #   puts header

  #   decoded = JsonWebToken.decode(header)
  #   puts "======================================================="
  #   puts decoded

  #   @current_user = User.find(decoded[:user_id]) if decoded
  #   p "==========================================================="
  #   puts @current_user.inspect
  # rescue ActiveRecord::RecordNotFound, JWT::DecodeError
  #   render json: { errors: ['Unauthorized or Invalid token'] }, status: :unauthorized
  # end

  def authenticate_request
    p "-================================authenticate_request===================================================="
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    puts header

    if token.blank?
      return render json: { errors: ['Token missing'] }, status: :unauthorized
    end

    decoded = JsonWebToken.decode(token)
    puts "======================================================="
    puts decoded

    if decoded.nil?
      return render json: { errors: ['Invalid token'] }, status: :unauthorized
    end

    @current_user = User.find(decoded[:user_id])
    p "==========================================================="
    puts @current_user.inspect
    p "------------successfully -----------------------------------------------------------------------------"

  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { errors: ['Unauthorized or Invalid token'] }, status: :unauthorized
  end



  # before_action :authorize_request

  # def authorize_request
  #   header = request.headers['Authorization']
  #   token = header.split(' ').last if header
  #   decoded = JsonWebToken.decode(token)
  #   @current_user = User.find(decoded[:user_id]) if decoded
  # rescue ActiveRecord::RecordNotFound, JWT::DecodeError
  #   render json: { error: 'Unauthorized access' }, status: :unauthorized
  # end

end
