module FloodRiskEngine
  module Steps
    class FormObjectFactory
      class << self
        def form_object_for(step, enrollment)
          klass = setup_form_object(enrollment)

          klass ||= form_object_class_map.fetch(step.to_sym) do
            fail "No form object defined for step #{step}"
          end
          klass.factory(enrollment)
        end

        # rubocop:disable Metrics/MethodLength
        # NB: use NullForm for steps with no html form.
        def form_object_class_map
          {
            grid_reference:          Steps::GridReferenceForm,
            review:                  Steps::NullForm,
            check_location:          Steps::NullForm,
            add_exemptions:          Steps::NullForm,
            check_exemptions:        Steps::NullForm,
            user_type:               Steps::UserTypeForm,
            local_authority:         Steps::NullForm,
            local_authority_address: Steps::NullForm,
            main_contact_name:       Steps::MainContactNameForm,
            main_contact_telephone:  Steps::NullForm,
            main_contact_email:      Steps::NullForm,
            main_contact_address:    Steps::NullForm,
            main_contact_postcode:   Steps::NullForm,
            email_someone_else:      Steps::NullForm,
            check_your_answers:      Steps::NullForm,
            declaration:             Steps::NullForm,
            confirmation:            Steps::NullForm
          }
        end

        private

        def setup_form_object(enrollment)
          begin
            "FloodRiskEngine::Steps::#{enrollment.step.classify}Form".constantize
          rescue
            Rails.logger.debug(" No Form Object found for step [#{enrollment.step}] - falling back to object_class map")
            nil
          end
        end
      end
    end
  end
end
