module FloodRiskEngine
  module ApplicationHelper
    def error_link_id(attribute)
      # with nested attributes can get full path e.g applicant_contact.full_name
      # we only want the last field
      field = attribute.to_s.split(/\./).last
      "form_group_#{field}"
    end

    def wrapper_options(attribute)
      {
        id: error_link_id(attribute)
      }
    end

    # EAFormBuilder is defined in the simple_form initializer
    # and adds id=form_group_#{attribute_name} to wrapper divs.
    def front_end_form_for(object, *args, &block)
      options = args.extract_options!
      simple_form_for(object, *(args << options.merge(builder: EAFormBuilder)), &block)
    end
  end
end
