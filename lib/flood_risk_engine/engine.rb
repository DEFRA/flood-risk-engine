
module FloodRiskEngine
  class Engine < ::Rails::Engine
    isolate_namespace FloodRiskEngine

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

#     # https://github.com/apotonick/reform
# require "reform/form/active_model/validations"
# Reform::Form.class_eval do
#   include Reform::Form::ActiveModel::Validations
# end
  end
end
