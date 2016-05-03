# Prototype refers to this as 'main' contact which is not that meaningful
# This is the contact who will be contacted about the activities, to arrange a visit
# or receive the registration confirmation, so for clarity we refer to this as the
# Correspondence Contact
#
module FloodRiskEngine
  module Steps
    class CorrespondenceContactNameForm < BaseForm

      def params_key
        :correspondence_contact_name
      end

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact

        unless contact
          contact = enrollment.correspondence_contact = FloodRiskEngine::Contact.new(contact_type: :correspondence)
        end

        new(contact, enrollment)
      end

      def self.locale_key
        "flood_risk_engine.enrollments.steps.correspondence_contact_name"
      end

      def self.name_max_length
        @name_max_length ||= TextFieldContentValidator.find_max_column_length(
          FloodRiskEngine::Contact, "full_name", 255
        )
      end

      def self.position_max_length
        @position_max_length ||= TextFieldContentValidator.find_max_column_length(
          FloodRiskEngine::Contact, "position", 255
        )
      end

      property :full_name

      validates :full_name, presence:
        {
          message: I18n.t("#{CorrespondenceContactNameForm.locale_key}.errors.full_name.blank")
        }

      validates :full_name, 'flood_risk_engine/text_field_content': true, allow_blank: true

      validates :full_name, length:
        {
          maximum: CorrespondenceContactNameForm.name_max_length,
          message: I18n.t("#{CorrespondenceContactNameForm.locale_key}.errors.full_name.too_long",
                          max_length: CorrespondenceContactNameForm.name_max_length)
        }

      validates :full_name, 'flood_risk_engine/name_format': true, allow_blank: true

      # The Job Title Field

      property :position

      validates :position, 'flood_risk_engine/text_field_content': true, allow_blank: true

      validates :position, length:
        {
          maximum: CorrespondenceContactNameForm.position_max_length,
          message: I18n.t("#{CorrespondenceContactNameForm.locale_key}.errors.position.too_long",
                          max_length: CorrespondenceContactNameForm.position_max_length)
        }

      def save
        super
        enrollment.correspondence_contact ||= model
        enrollment.save
      end
    end
  end
end
