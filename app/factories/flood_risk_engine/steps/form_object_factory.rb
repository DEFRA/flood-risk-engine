module FloodRiskEngine
  module Steps
    class FormObjectFactory
      class << self
        def form_object_for(step, enrollment)
          klass = form_object_class_map.fetch(step.to_sym) do
            fail "No form object defined for step #{step}"
          end
          klass.factory(enrollment)
        end

        # NB: use NullForm for steps with no html form.
        def form_object_class_map
          {
            grid_reference:         Steps::GridReferenceForm,
            applicant_contact_name: Steps::ApplicantContactNameForm,
            organisation_type:      Steps::OrganisationTypeForm,
            review:                 Steps::NullForm
          }
        end
      end
    end
  end
end
