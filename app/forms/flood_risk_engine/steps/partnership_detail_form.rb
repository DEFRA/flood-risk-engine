module FloodRiskEngine
  module Steps
    class PartnershipDetailForm < BaseStepsForm
      def initialize(enrollment)
        @enrollment = enrollment
        remove_incomplete_partners
        super(enrollment.reload)
      end

      def save
        true
      end

      def validate(_params)
        true
      end

      def show_continue_button?
        (enrollment.partners.count > 1) && super
      end

      def no_header_in_show
        true
      end

      private

      # If a user starts creating a partner and then goes back to the
      # start of the process, then an incomplete partner can be created
      # These need to be tidied up before progressing further.
      def remove_incomplete_partners
        enrollment.partners.each do |partner|
          unless partner.address
            partner.destroy
            partner.contact.destroy
          end
        end
      end
    end
  end
end
