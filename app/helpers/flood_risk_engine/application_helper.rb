module FloodRiskEngine
  module ApplicationHelper

    # This is a bit of a hack - see discussion e.g. here:
    # http://www.candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
    # This isolated engine cannot access helper methods in the parent app, which is fair enough.
    # However if views defined in this engine are displayed inside a layout defined by the parent
    # app, and that layout calls helper methods (eg in ApplicationHelper) which also defined in the
    # parent app, this will result in undefined method errors. To get around having to duplicate
    # those helper methods here in the engine, forward any methods we not defined here to main_app.
    def method_missing(method, *args, &block)
      main_app.respond_to?(method) ? main_app.send(method, *args) : super
    end

    # This helper  adds a form-group DIV around form elements,
    # and takes the actual form fields as a content block.
    #
    # Some coupling with app/views/flood_risk_engine/enrollments/_validation_errors.html.erb which displays
    # the actual validation errors and links between error display and the
    # associated form-group defined here
    #
    # Example Usage :
    # <%= form_group_and_validation(@enrollment, :base) do %>
    #   <%= form.radio_button "blah", "new", checked: false, class: "radio" %>
    #   <%= form.radio_button "blah", "renew", checked: false, class: "radio" %>
    # <% end %>
    #
    def form_group_and_validation(form, attribute, &block)
      content = block_given? ? capture(&block) : ""
      classes = ["form-group"]
      options = {
        id: error_link_id(attribute),
        role: "group"
      }

      if form && form.errors[attribute].any?
        classes << "error"
        content = content_tag(:span,
                              form.errors[attribute].first,
                              class: "error-message") + content
      end
      content_tag(:div, content, options.merge(class: classes.join(" ")))
    end

    def error_link_id(attribute)
      # with nested attributes can get full path e.g applicant_contact.full_name
      # we only want the last field
      field = attribute.to_s.split(/\./).last
      "form_group_#{field}"
    end

    def page_title(title)
      return unless title.present?

      stripped_title = title.gsub(/’/, %('))

      if content_for? :page_title
        content_for :page_title, " | #{stripped_title}"
      else
        content_for :page_title, stripped_title.to_s
      end

      title
    end

    def step_t(step, *args)
      args[0] = "flood_risk_engine.enrollments.steps.#{step}#{args.first}"
      t(*args)
    end

  end
end
