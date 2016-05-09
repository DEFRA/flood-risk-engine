require "validates_email_format_of"
require "active_model/validations/confirmation"

module FloodRiskEngine
  module Steps
    class CorrespondenceContactEmailForm < BaseForm

      def self.factory(enrollment)
        enrollment.correspondence_contact ||= FloodRiskEngine::Contact.new(contact_type: :correspondence)

        new(enrollment.correspondence_contact, enrollment)
      end

      def self.params_key
        :correspondence_contact_email
      end

      property :email_address
      property :email_address_confirmation, virtual: true

      # This group manages the main email_address field, confirmation is dependent on results of this group
      validation :email_address_valid? do
        validates :email_address, presence: {
          message: I18n.t("#{CorrespondenceContactEmailForm.locale_key}.errors.email_address.blank")
        }

        validates :email_address, email_format: {
          allow_blank: true,
          message: I18n.t("#{CorrespondenceContactEmailForm.locale_key}.errors.email_address.format")
        }
      end

      # If you want to reach the form to check for errors use unless/if you can via
      #     unless: ->(form) { form.changed?(:email_address) }
      #     unless: ->(form) { form.errors.any? }
      #
      # This reform validation group only runs, if previous email group passed - email_address_valid?
      #
      validation :confirmation_present?, if: :email_address_valid? do
        validates :email_address_confirmation, presence: {
          message: I18n.t("#{CorrespondenceContactEmailForm.locale_key}.errors.email_address_confirmation.blank")
        }
      end

      # The helpers ; allow_blank: true, allow_nil: true  ; only seem to apply to the email_address field
      # not the confirmation, so this format prevents both format & blank messages when conf = blank
      #
      validation :passwords_match, if: :confirmation_present? do
        # Although not specified, Rails automatically validates against a field called email_address_confirmation
        validates :email_address, confirmation: {
          message: I18n.t("#{CorrespondenceContactEmailForm.locale_key}.errors.email_address_confirmation.format")
        }
      end
      #       validates :email_address_confirmation,
      #                 presence: {
      #                   message: validation_message_when("email_address_confirmation.blank"),
      #                   unless: ->(form) { form.errors.any? }
      #                 }
      #
      #       validates :email_address,
      #                 confirmation: {
      #                   message: validation_message_when("email_address_confirmation.format"),
      #                   unless: ->(form) { form.errors.any? }
      #                 }
      def save
        super
        enrollment.correspondence_contact ||= model
        enrollment.save
      end

      # Force use of the factory to create instances of this class
      class << self
        private

        def new(model, enrollment = nil)
          super(model, enrollment)
        end
      end

    end
  end
end
