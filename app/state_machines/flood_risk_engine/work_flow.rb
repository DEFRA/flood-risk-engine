module FloodRiskEngine
  # Work flows are sequences of steps
  # This class is designed to allow work flows to be defined as arrays,
  # and then be converted into a hash suitable for input into a state
  # engine.
  class WorkFlow
    # Define each work flow within Definitions
    module Definitions
      module_function

      def local_authority
        between_start_and_finish do
          %i[
            local_authority
            local_authority_postcode
            local_authority_address
          ]
        end
      end

      def limited_company
        between_start_and_finish do
          %i[
            limited_company_number
            limited_company_name
            limited_company_postcode
            limited_company_address
          ]
        end
      end

      def limited_liability_partnership
        between_start_and_finish do
          %i[
            limited_liability_partnership_number
            limited_liability_partnership_name
            limited_liability_partnership_postcode
            limited_liability_partnership_address
          ]
        end
      end

      def individual
        between_start_and_finish do
          %i[
            individual_name
            individual_postcode
            individual_address
          ]
        end
      end

      def partnership
        between_start_and_finish do
          %i[
            partnership
            partnership_postcode
            partnership_address
            partnership_details
          ]
        end
      end

      def other
        between_start_and_finish do
          %i[
            other
            other_postcode
            other_address
          ]
        end
      end

      def unknown
        start + [:unknown]
      end

      def start
        %i[
          add_exemptions
          check_exemptions
          grid_reference
          user_type
        ]
      end

      def finish
        # correspondence_contact_name = prototype urls refers to this as 'main' contact
        # correspondence_contact_telephone = but it is essentially - "Who should we contact about this activity?"
        %i[
          correspondence_contact_name
          correspondence_contact_telephone
          correspondence_contact_email
          email_someone_else
          check_your_answers
          declaration
        ]
      end

      def between_start_and_finish
        start + yield + finish
      end

    end

    # Enter the name of one of the Definitions defined above,
    # and WorkFlow#for will return the matching hash
    def self.for(definition)
      new(definition).to_hash
    end

    attr_reader :work_flow
    def initialize(method)
      @work_flow = Definitions.send method
    end

    def to_hash
      make_hash work_flow
    end

    # Converts [:a, :b, :c] into
    # {:a => :b, :b => :c}
    def make_hash(array)
      all_but_last = array[0..-2]
      all_but_first = array[1..-1]
      pairs = [all_but_last, all_but_first].transpose
      Hash[pairs]
    end
  end
end
