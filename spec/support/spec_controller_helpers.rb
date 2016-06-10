module SpecControllerHelpers

  def set_journey_token
    session[:journey_token] = enrollment.token
  end

end
