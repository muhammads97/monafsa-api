class HealthCheckController < ApiController

  def status
    throw 'not healthy' if params.key? 'unhealthy'
    json_response(message: 'Healthy!!')
  end
end