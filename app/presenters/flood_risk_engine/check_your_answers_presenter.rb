# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module FloodRiskEngine
  class CheckYourAnswersPresenter < BasePresenter
    def initialize(transient_registration)
      super(transient_registration, nil)
    end

    def registration_rows
      [
        exemption_row,
        location_rows,
        company_rows
      ].flatten
    end

    def contact_rows
      row_array = [contact_name_row, contact_phone_row, contact_email_row]
      row_array << additional_contact_email_row if additional_contact_email.present?

      row_array
    end

    private

    def location_rows
      row_array = [grid_reference_row, site_description_row]
      row_array << dredging_length_row if dredging_length.present?

      row_array
    end

    def company_rows
      row_array = [business_type_row]

      if partnership?
        transient_people.each { |partner| row_array << partner_row(partner) }
      else
        row_array << company_number_row if company_no_required?
        row_array += [company_name_row, company_address_row]
      end

      row_array
    end

    def exemption_row
      exemption = exemptions.first

      {
        title: I18n.t("#{i18n_scope}.exemption.title"),
        value: "#{exemption.code} #{exemption.summary}"
      }
    end

    def grid_reference_row
      {
        title: I18n.t("#{i18n_scope}.grid_reference.title"),
        value: temp_grid_reference
      }
    end

    def site_description_row
      {
        title: I18n.t("#{i18n_scope}.site_description.title"),
        value: temp_site_description
      }
    end

    def dredging_length_row
      {
        title: I18n.t("#{i18n_scope}.dredging_length.title"),
        value: I18n.t("#{i18n_scope}.dredging_length.value",
                      dredging_length: dredging_length,
                      count: dredging_length)
      }
    end

    def business_type_row
      formatted_business_type = FloodRiskEngine::TransientRegistration::BUSINESS_TYPES.key(business_type)

      {
        title: I18n.t("#{i18n_scope}.business_type.title"),
        value: I18n.t("#{i18n_scope}.business_type.value.#{formatted_business_type}")
      }
    end

    def company_number_row
      {
        title: I18n.t("#{i18n_scope}.company_number.title"),
        value: company_number
      }
    end

    def company_name_row
      {
        title: I18n.t("#{i18n_scope}.company_name.title"),
        value: company_name
      }
    end

    def company_address_row
      {
        title: I18n.t("#{i18n_scope}.company_address.title"),
        value: displayable_address(company_address)
      }
    end

    def partner_row(partner)
      value = [partner.full_name, displayable_address(partner.transient_address)].join(", ")

      {
        title: I18n.t("#{i18n_scope}.partner.title"),
        value: value
      }
    end

    def contact_name_row
      value = if contact_position.present?
                I18n.t("#{i18n_scope}.contact_name.value.position",
                       contact_name: contact_name,
                       contact_position: contact_position)
              else
                I18n.t("#{i18n_scope}.contact_name.value.no_position",
                       contact_name: contact_name)
              end
      {
        title: I18n.t("#{i18n_scope}.contact_name.title"),
        value: value
      }
    end

    def contact_phone_row
      {
        title: I18n.t("#{i18n_scope}.contact_phone.title"),
        value: contact_phone
      }
    end

    def contact_email_row
      {
        title: I18n.t("#{i18n_scope}.contact_email.title"),
        value: contact_email
      }
    end

    def additional_contact_email_row
      {
        title: I18n.t("#{i18n_scope}.additional_contact_email.title"),
        value: additional_contact_email
      }
    end

    def displayable_address(address)
      [address.organisation, address.premises, address.street_address,
       address.locality, address.city, address.postcode].reject(&:blank?).join(", ")
    end

    def i18n_scope
      "flood_risk_engine.check_your_answers_forms.new.rows"
    end
  end
end
# rubocop:enable Metrics/ClassLength
