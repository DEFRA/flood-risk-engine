module FloodRiskEngine
  module Steps
    class AddExemptionsForm < BaseForm
      property :exemption_ids

      attr_reader :all_exemptions

      validates(
        :exemption_ids,
        length: {
          minimum: 1,
          maximum: 1,
          message: :select_at_lease_one_exemptions
        }
      )

      def initialize(enrollment)
        super enrollment
        @all_exemptions = Exemption.all
      end

      def validate(params)
        # The validation doesn't recognise { exemption_ids: "" } as invalid
        # As a workaround, we remove any empty hashes from the params
        # before the validation is actioned
        super(
          if params.fetch(params_key, {}).reject { |_, v| v.blank? }.empty?
            {}
          else
            params
          end
        )
      end

      def save
        result = super

        # This is the first point at which we have a confirmed/valid Exemption(s) selected
        # so we check here, has a BO user been set (before redirecting from BO New)
        # and if required, assign related mode.
        # We want this logic as isolated as possible hence not in a model call back or similar
        if enrollment.updated_by_user_id.present?
          enrollment.enrollment_exemptions.each(&:fully_assisted!)
          enrollment.enrollment_exemptions.each(&:fully_assisted!)
        end

        result
      end

      def exemption_ids=(id)
        super [id]
      end

      def params_key
        :add_exemptions
      end
    end
  end
end
