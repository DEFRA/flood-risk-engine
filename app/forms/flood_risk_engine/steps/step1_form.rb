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

      # Moved knowledge of parent key in params (defined in the html form using as: ..
      # otherwise we get very longs form field names etc - see step1.html.erb)
      # since knowing how to extract the form data, and what the expectation of the
      # params sctructure is, is best here.
      def validate(params)
        # There may be no step1 key in params if no form fields had
        # a value - hence defaulting to an empty hash
        super params.fetch(:step1) { Hash.new }
      end
    end
  end
end
