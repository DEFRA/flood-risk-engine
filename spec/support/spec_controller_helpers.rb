# frozen_string_literal: true

module SpecControllerHelpers

  def set_journey_token
    cookies.encrypted[:journey_token] = enrollment.token
  end

end
