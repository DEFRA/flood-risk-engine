module FloodRiskEngine
  module Reviewing
    module RowBuilders
      class Base
        include Engine.routes.url_helpers
        attr_reader :enrollment, :i18n_scope

        def initialize(options)
          @enrollment = options[:enrollment]
          @i18n_scope = options[:i18n_scope]
        end

        def row_t(step, key, opts = {})
          I18n.t(".rows.#{step}.#{key}", opts.merge(scope: i18n_scope))
        end

        def enrollment_presenter
          @enrollment_presenter ||= EnrollmentPresenter.new(enrollment)
        end
      end
    end
  end
end
