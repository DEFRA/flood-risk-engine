module FloodRiskEngine
  module ApplicationHelper
    def page_title(title)
      return unless title.present?

      stripped_title = title.gsub(/’/, %('))

      if content_for? :page_title
        content_for :page_title, " - #{stripped_title} - GOV.UK"
      else
        content_for :page_title, stripped_title.to_s
      end

      title
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
  end
end
