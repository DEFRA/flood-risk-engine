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
