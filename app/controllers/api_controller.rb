class ApiController < ActionController::API
  helper ApiHelper
  include Responseable  
  include Localizable
  include ActAsApiRequest

  before_action :ensure_json_request
  before_action :set_response_metadata

  protected

  def ensure_json_request
    request.format = :json
  end

  def set_response_metadata
    @response_metadata = {}
  end
end