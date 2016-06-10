module SpecControllerHelpers

  include FloodRiskEngine::SimpleEncoding

  def set_journey_token
    cookies[:journey_token] = encode(enrollment.token)
  end

end
