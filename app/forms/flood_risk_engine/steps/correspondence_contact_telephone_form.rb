module FloodRiskEngine
  module Steps
    class CorrespondenceContactTelephoneForm < BaseForm

      def self.factory(enrollment)
        super enrollment, factory_type: :correspondence_contact
      end

      def self.params_key
        :correspondence_contact_telephone
      end

      property :telephone_number

      # phone validation from https://github.com/daddyz/phonelib
      validates(
        :telephone_number,
        phone: {
          message: I18n.t("#{locale_key}.errors.telephone_number.invalid"),
          allow_blank: true
        },
        presence: {
          message: I18n.t("#{locale_key}.errors.telephone_number.blank")
        }
      )

      def save
        super
        enrollment.correspondence_contact ||= model
        enrollment.save
      end

    end
  end
end
