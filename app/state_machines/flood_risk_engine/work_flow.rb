module FloodRiskEngine
  # Work flows are sequences of steps
  # This class is designed to allow work flows to be defined as arrays,
  # and then be converted into a hash suitable for input into a state
  # engine.
  class WorkFlow
    # Define each work flow within Definitions
    module Definitions
      extend self

      def local_authority
        start + local_authority_branch + finish
      end

      def start
        [
          :check_location,
          :add_exemptions,
          :check_exemptions,
          :grid_reference,
          :user_type
        ]
      end

      def local_authority_branch
        [
          :local_authority,
          :local_authority_address,
          :main_contact_name,
          :main_contact_telephone,
          :main_contact_email,
          :main_contact_address,
          :main_contact_postcode
        ]
      end

      def finish
        [
          :email_someone_else,
          :check_your_answers,
          :declaration,
          :confirmation
        ]
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
