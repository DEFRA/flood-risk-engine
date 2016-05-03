module FloodRiskEngine
  module Steps
    class FormObjectFactory
      class << self
        def form_object_for(step, enrollment)
          klass = form_object_class_map[step.to_sym] || setup_form_object(step)

          raise(FormObjectError, "No form object defined for step #{step}") unless klass

          klass.factory(enrollment)
        end

        # rubocop:disable Metrics/MethodLength
        # NB: use NullForm for steps with no html form.
        def form_object_class_map
          @form_object_class_map ||= {
            grid_reference:          Steps::GridReferenceForm,
            review:                  Steps::NullForm,
            add_exemptions:          Steps::AddExemptionsForm,
            check_exemptions:        Steps::NullForm,
            user_type:               Steps::UserTypeForm,
            local_authority_address: Steps::NullForm,

            correspondence_contact_telephone:  Steps::NullForm,
            correspondence_contact_address:    Steps::NullForm,
            correspondence_contact_postcode:   Steps::NullForm,

            individual_name:         Steps::NullForm,
            limited_company_number:  Steps::NullForm,
            limited_liability_number: Steps::NullForm,
            other:                   Steps::NullForm,
            partnership:             Steps::NullForm,
            email_someone_else:      Steps::NullForm,
            check_your_answers:      Steps::NullForm,
            declaration:             Steps::NullForm,
            confirmation:            Steps::NullForm
          }
        end

        private

        def setup_form_object(step)
          form_name = "FloodRiskEngine::Steps::#{step.to_s.classify}Form"
          begin
            form_name.constantize
          rescue NameError => x
            Rails.logger.debug(x.inspect)
            Rails.logger.debug("Error loading Form class #{form_name} ")
            nil
          end
        end

      end
    end
  end
end
