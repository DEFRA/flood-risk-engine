# frozen_string_literal: true

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
        state :manage_partners_form

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
        end

        event :back do
        end
      end
    end
  end
end
