module FloodRiskEngine
  module ApplicationHelper
    def error_link_id(attribute)
      # with nested attributes can get full path e.g applicant_contact.full_name
      # we only want the last field
      field = attribute.to_s.split(/\./).last
      "form_group_#{field}"
    end

    def set_page_title(title)
      return unless title.present?

      stripped_title = title.gsub(/’/, %{'})

      if content_for? :page_title
        content_for :page_title, " | #{stripped_title}"
      else
        content_for :page_title, "GOV.UK | #{stripped_title}"
      end

      title
    end

  end
end
