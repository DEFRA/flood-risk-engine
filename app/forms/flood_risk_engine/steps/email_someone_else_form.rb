require "validates_email_format_of"
require "active_model/validations/confirmation"

module FloodRiskEngine
  module Steps
    class EmailSomeoneElseForm < BaseStepsForm

      def self.factory(enrollment)
        enrollment.secondary_contact ||= Contact.new
        new(enrollment.secondary_contact, enrollment)
      end

      def self.params_key
        :email_someone_else
      end

      def self.t(key)
        I18n.t([locale_key, key].join)
      end

      property :email_address
      property :email_address_confirmation, virtual: true

      validates(
        :email_address,
        presence: {
          message: t(".errors.email_address.blank"),
          if: proc { |contact| contact.email_address_confirmation.present? }
        },
        email_format: {
          allow_blank: true,
          message: t(".errors.email_address.invalid")
        },
        confirmation: {
          allow_blank: true,
          message: t(".errors.email_address_confirmation.invalid"),
          # Need `if` to skip this if confirmation is an empty string.
          if: proc { |contact| contact.email_address_confirmation.present? }
        }
      )

      validates(
        :email_address_confirmation,
        presence: {
          message: t(".errors.email_address_confirmation.blank"),
          if: proc { |contact| contact.email_address.present? }
        }
      )

      def save
        super
        enrollment.secondary_contact ||= model
        enrollment.save
      end

      # Handle situation if page returned to via back
      def email_address_confirmation
        current = super
        return email_address if current.blank? && !changed.key?("email_address")
        current
      end

    end
  end
end
