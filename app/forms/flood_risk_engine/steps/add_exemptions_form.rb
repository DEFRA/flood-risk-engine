module FloodRiskEngine
  module Steps
    class AddExemptionsForm < BaseForm
      property :exemptions

      def self.factory(enrollment)
        new(enrollment)
      end
      validates :exemptions, length: { minimum: 1 }

      attr_reader :exemptions

      def initialize(enrollment)
        super enrollment
        @exemptions = Exemption.all
      end

      def exemptions=(ids)
        return super([]) unless ids.respond_to?(:collect!) && ids.present?
        super Exemption.where(id: ids.collect!(&:to_i))
      end

      def params_key
        :add_exemptions
      end
    end
  end
end
