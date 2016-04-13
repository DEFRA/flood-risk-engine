module FloodRiskEngine
  module Steps
    class ActivityLocationForm < BaseForm
      property :grid_reference
      validates :grid_reference, presence: true

      # This method is responsible for constructing an instance if its class.
      # It alone knows what model the form object will be passed.
      # For example if this form object deals with updating an address it might
      # be initialised like so
      #   Step1Form.new(enrollment.address, enrollment)
      def self.factory(enrollment)

        # TODO: what happens if they click back ? get the site address ?
        location = Location.new  # enrollment.site_address || Location.new
        new(location, enrollment)
      end

      def params_key
        :activity_location
      end

      def save
        super
        enrollment.save
      end
    end
  end
end
