# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/BlockLength
module FloodRiskEngine
  module CanUseNewRegistrationWorkflow
    extend ActiveSupport::Concern

    included do
      include AASM

      aasm column: :workflow_state do
        # States / forms

        # Start
        state :start_form, initial: true

        # Exemptions
        state :exemption_form
        state :confirm_exemption_form

        # Location of activity
        state :site_grid_reference_form

        # Business type
        state :business_type_form

        # Company details
        state :company_number_form
        state :company_name_form
        state :company_postcode_form
        state :company_address_lookup_form
        state :company_address_manual_form

        # Partner details
        state :partner_name_form
        state :partner_postcode_form
        state :partner_address_lookup_form
        state :partner_address_manual_form
        state :partner_overview_form

        # Contact details
        state :contact_name_form
        state :contact_phone_form
        state :contact_email_form
        state :additional_contact_email_form

        # End pages
        state :check_your_answers_form
        state :declaration_form
        state :registration_complete_form

        # Transitions
        event :next do
          # Start
          transitions from: :start_form,
                      to: :exemption_form

          # Exemption
          transitions from: :exemption_form,
                      to: :confirm_exemption_form

          transitions from: :confirm_exemption_form,
                      to: :site_grid_reference_form

          # Location of activity
          transitions from: :site_grid_reference_form,
                      to: :business_type_form

          # Business type
          transitions from: :business_type_form,
                      to: :partner_overview_form,
                      if: :can_see_partner_overview?

          transitions from: :business_type_form,
                      to: :partner_name_form,
                      if: :should_have_partners?

          transitions from: :business_type_form,
                      to: :company_number_form,
                      if: :should_have_company_number?

          transitions from: :business_type_form,
                      to: :company_name_form

          # Company details
          transitions from: :company_number_form,
                      to: :company_name_form

          transitions from: :company_name_form,
                      to: :company_postcode_form

          transitions from: :company_postcode_form,
                      to: :company_address_manual_form,
                      if: :skip_to_manual_address?

          transitions from: :company_postcode_form,
                      to: :company_address_lookup_form

          transitions from: :company_address_lookup_form,
                      to: :company_address_manual_form,
                      if: :skip_to_manual_address?

          transitions from: :company_address_lookup_form,
                      to: :contact_name_form

          transitions from: :company_address_manual_form,
                      to: :contact_name_form

          # Partner details
          transitions from: :partner_name_form,
                      to: :partner_postcode_form

          transitions from: :partner_postcode_form,
                      to: :partner_address_manual_form,
                      if: :skip_to_manual_address?

          transitions from: :partner_postcode_form,
                      to: :partner_address_lookup_form

          transitions from: :partner_address_lookup_form,
                      to: :partner_address_manual_form,
                      if: :skip_to_manual_address?

          transitions from: :partner_address_lookup_form,
                      to: :partner_overview_form

          transitions from: :partner_address_manual_form,
                      to: :partner_overview_form

          transitions from: :partner_overview_form,
                      to: :contact_name_form

          # Contact details
          transitions from: :contact_name_form,
                      to: :contact_phone_form

          transitions from: :contact_phone_form,
                      to: :contact_email_form

          transitions from: :contact_email_form,
                      to: :additional_contact_email_form

          transitions from: :additional_contact_email_form,
                      to: :check_your_answers_form

          # End pages
          transitions from: :check_your_answers_form,
                      to: :declaration_form

          transitions from: :declaration_form,
                      to: :registration_complete_form
        end

        event :back do
          # Exemption
          transitions from: :exemption_form,
                      to: :start_form

          transitions from: :confirm_exemption_form,
                      to: :exemption_form

          # Location of activity
          transitions from: :site_grid_reference_form,
                      to: :confirm_exemption_form

          # Business type
          transitions from: :business_type_form,
                      to: :site_grid_reference_form

          # Company details
          transitions from: :company_number_form,
                      to: :business_type_form

          transitions from: :company_name_form,
                      to: :company_number_form,
                      if: :should_have_company_number?

          transitions from: :company_name_form,
                      to: :business_type_form

          transitions from: :company_postcode_form,
                      to: :company_name_form

          transitions from: :company_address_lookup_form,
                      to: :company_postcode_form

          transitions from: :company_address_manual_form,
                      to: :company_postcode_form

          # Partner details
          transitions from: :partner_name_form,
                      to: :partner_overview_form,
                      if: :can_see_partner_overview?

          transitions from: :partner_name_form,
                      to: :business_type_form

          transitions from: :partner_postcode_form,
                      to: :partner_name_form

          transitions from: :partner_address_lookup_form,
                      to: :partner_postcode_form

          transitions from: :partner_address_manual_form,
                      to: :partner_postcode_form

          transitions from: :partner_overview_form,
                      to: :business_type_form

          # Contact details
          transitions from: :contact_name_form,
                      to: :partner_overview_form,
                      if: :should_have_partners?

          transitions from: :contact_name_form,
                      to: :company_address_manual_form,
                      if: :company_address_was_manually_entered?

          transitions from: :contact_name_form,
                      to: :company_address_lookup_form

          transitions from: :contact_phone_form,
                      to: :contact_name_form

          transitions from: :contact_email_form,
                      to: :contact_phone_form

          transitions from: :additional_contact_email_form,
                      to: :contact_email_form

          # End pages
          transitions from: :check_your_answers_form,
                      to: :additional_contact_email_form

          transitions from: :declaration_form,
                      to: :check_your_answers_form
        end

        event :skip_to_manual_address do
          transitions from: :company_postcode_form,
                      to: :company_address_manual_form

          transitions from: :company_address_lookup_form,
                      to: :company_address_manual_form

          transitions from: :partner_postcode_form,
                      to: :partner_address_manual_form

          transitions from: :partner_address_lookup_form,
                      to: :partner_address_manual_form
        end

        event :add_new_partner do
          transitions from: :partner_overview_form,
                      to: :partner_name_form
        end
      end
    end

    private

    def should_have_partners?
      partnership?
    end

    def should_have_company_number?
      company_no_required?
    end

    def skip_to_manual_address?
      address_finder_error.present?
    end

    def company_address_was_manually_entered?
      return false if company_address.blank?

      company_address.manual?
    end

    def can_see_partner_overview?
      existing_partners?
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/ModuleLength
