# This simple null form over rides validate/save etc because there is no data to
# collect on this page
#
module FloodRiskEngine
  module Steps
    class CheckLocationForm < FloodRiskEngine::Steps::BaseForm
      attr_accessor :redirection_url
      attr_accessor :redirect
      alias redirect? redirect

      property :location_check, virtual: true

      # Errors stored under :location_check
      validates :location_check,
                presence: {
                  message: I18n.t("errors.select_yes_or_no")
                }

      def self.factory(enrollment)
        new(enrollment).tap do |form|
          form.redirection_url = FloodRiskEngine.config.redirection_url_on_location_unchecked
        end
      end

      def save
        self.redirect = (location_check == "no")
        enrollment.save
      end

      def params_key
        :check_location
      end
    end
  end
end
