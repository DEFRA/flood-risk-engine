module FloodRiskEngine
  module ApplicationHelper
    def title
      title_elements = [title_text, "Register a flood risk activity exemption", "GOV.UK"]
      # Remove empty elements, for example if no specific title is set
      title_elements.delete_if(&:empty?)
      title_elements.join(" - ")
    end

    def displayable_address(address)
      return [] unless address.present?

      # Get all the possible address lines, then remove the blank ones
      [address.organisation,
       address.premises,
       address.street_address,
       address.locality,
       address.city,
       address.postcode].reject(&:blank?)
    end

    private

    def title_text
      # Check if the title is set in the view (we do this for High Voltage pages)
      return content_for :title if content_for?(:title)

      # Otherwise, look up translation key based on controller path, action name and .title
      # Solution from https://coderwall.com/p/a1pj7w/rails-page-titles-with-the-right-amount-of-magic
      title = t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: "")
      return title if title.present?

      # Default to title for "new" action if the current action doesn't return anything
      t("#{controller_path.tr('/', '.')}.new.title", default: "")
    end
  end
end
