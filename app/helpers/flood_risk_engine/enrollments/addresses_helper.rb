module FloodRiskEngine
  module Enrollments
    module AddressesHelper

      # disbale for now as not sure best way to stop this warning..make step back etc options in {}
      # rubocop:disable Metrics/ParameterLists
      def new_address_path(enrollment:, addressable:, postcode:, address_type:,
                           step_back_to_postcode: false, target_step: nil)
        new_enrollment_address_path(
          enrollment,
          addressable_id: addressable.id,
          addressable_type: addressable.class.to_s,
          postcode: postcode,
          address_type: address_type,
          step_back_to_postcode: step_back_to_postcode,
          target_step: target_step
        )
      end
      # rubocop:enable Metrics/ParameterLists

      # The change postcode page should either be the current step or the previous step.
      # set :step_back_to_postcode to true if the postcode step will be the
      # previous step.
      def change_postcode_path(enrollment, step_back_to_postcode: false)
        step = step_back_to_postcode ? enrollment.previous_step : enrollment.current_step
        enrollment_step_path(enrollment, step)
      end

    end
  end
end
