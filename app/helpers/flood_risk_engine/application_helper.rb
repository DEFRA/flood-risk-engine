module FloodRiskEngine
  module ApplicationHelper
    def error_link_id(attribute)
      # with nested attributes can get full path e.g applicant_contact.full_name
      # we only want the last field
      field = attribute.to_s.split(/\./).last
      "form_group_#{field}"
    end
  end
end
