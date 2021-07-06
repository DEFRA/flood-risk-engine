# frozen_string_literal: true

module FloodRiskEngine
  module CanSetCustomErrorMessage
    extend ActiveSupport::Concern

    included do
      def self.custom_error_messages(attribute, *errors)
        messages = {}

        errors.each do |error|
          messages[error] = I18n.t("activemodel.errors.models."\
                                       "flood_risk_engine/#{form_name}"\
                                       ".attributes.#{attribute}.#{error}")
        end

        messages
      end

      def self.form_name
        name.split("::").last.underscore
      end
    end
  end
end
