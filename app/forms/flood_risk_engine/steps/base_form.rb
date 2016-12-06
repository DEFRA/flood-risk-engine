require_dependency "reform"

# Common step form functionality.
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form
      include ActionView::Helpers::TranslationHelper
      include ActiveModel::Validations

      feature Reform::Form::ActiveModel::Validations

      include BaseFormCommon
      extend BaseFormCommon
      def self.factory(enrollment, factory_type: :default)
        case factory_type
        when :correspondence_contact
          enrollment.correspondence_contact ||= Contact.new(contact_type: :correspondence)
          new(enrollment.correspondence_contact, enrollment)
        when :primary_address
          address = enrollment.organisation.primary_address ||= Address.new(address_type: :primary)
          new(address, enrollment)
        when :address_search
          enrollment.address_search ||= AddressSearch.new
          new(enrollment.address_search, enrollment)
        when :organisation
          organisation = enrollment.organisation ||= Organisation.new
          new(organisation, enrollment)
        else # default
          new(enrollment)
        end
      end
      # rubocop:enable Metrics/MethodLength

      delegate :model_name, to: :model

      def self.t(locale, args = {})
        I18n.t locale, args.merge(scope: locale_key)
      end

      def t(locale, args = {})
        self.class.t(locale, args)
      end

      # So we can always build an enrollment step url
      delegate :id, to: :enrollment, prefix: true

      def redirect?
        false
      end

      def initialize(model, enrollment = nil)
        @enrollment = enrollment || model
        super(model)
      end

      def validate(params)
        super params.fetch(params_key, {})
      end

      def view_path
        :show
      end

      attr_reader :enrollment

      # The default header CSS in show is consistent for most pages but now and then a form/partial needs
      # to over ride the header box and define its own styling
      attr_reader :no_header_in_show

      # Default is to render a view/partial whose name == step, but for some reason step
      # is a separate local and not part of the Form, so we cannot return it as a default here.
      # Leave it to the show view to determine whether to render default or a diff partial
      attr_reader :partial_to_render

      def partial_to_render?
        !partial_to_render.nil?
      end

      def show_continue_button?
        enrollment.can?(:go_forward)
      end

      protected

      def logger
        Rails.logger
      end
    end
  end
end
