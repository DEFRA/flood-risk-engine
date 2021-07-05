module FloodRiskEngine
  module Steps
    class LocalAuthorityForm < BaseStepsForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
      end

      def self.params_key
        :local_authority
      end

      def self.name_max_length
        200
      end

      property :name

      validates :name, presence: { message: t(".errors.name.blank") }

      validates :name, 'EA::Validators::CompaniesHouseName': {
        message: t(".errors.name.invalid"),
        allow_blank: true
      }

      validates :name, length: {
        maximum: LocalAuthorityForm.name_max_length,
        message: t(".errors.name.too_long", max: LocalAuthorityForm.name_max_length)
      }

    end
  end
end
