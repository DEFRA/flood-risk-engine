module FloodRiskEngine
  module Steps
    class Step1Form < BaseForm
      property :dummy_boolean
      validates :dummy_boolean, presence: true

      # This method is responsible for constructing an instance if its class.
      # It alone knows what model the form object will be passed.
      # For example if this form object deals with updating an address it might
      # be initialised like so
      #   Step1Form.new(enrollment.address, enrollment)
      def self.factory(enrollment)
        new(enrollment)
      end

      def params_key
        :step1
      end
    end
  end
end
