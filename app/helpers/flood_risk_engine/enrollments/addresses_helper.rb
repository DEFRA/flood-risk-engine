module FloodRiskEngine
  module Enrollments
    module AddressesHelper

      def new_address_path(enrollment:, addressable:, postcode:, address_type:)
        new_enrollment_address_path(
          enrollment,
          addressable_id: addressable.id,
          addressable_type: addressable.class.to_s,
          postcode: postcode,
          address_type: address_type
        )
      end

    end
  end
end
