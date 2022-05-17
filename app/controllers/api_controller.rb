class ApiController < ActionController::API
  helper ApiHelper
  include Responseable  
  include Localizable
  include ActAsApiRequest
  include Pundit

  before_action :ensure_json_request
  before_action :set_response_metadata

  def current_user
    @current_user
  end
  protected

  def ensure_json_request
    request.format = :json
  end

  def set_response_metadata
    @response_metadata = {}
  end

  def authenticate_user!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end