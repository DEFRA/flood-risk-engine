# frozen_string_literal: true

module FloodRiskEngine
  module CanAddValidationErrors
    private

    def add_validation_error(record, attribute, error)
      record.errors.add(attribute,
                        error,
                        message: error_message(record, attribute, error))
    end

    def error_message(record, attribute, error)
      class_name = record.class.to_s.underscore
      I18n.t("activemodel.errors.models.#{class_name}.attributes.#{attribute}.#{error}")
    end
  end
end
