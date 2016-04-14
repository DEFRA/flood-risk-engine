
module FloodRiskEngine
  class Engine < ::Rails::Engine
    isolate_namespace FloodRiskEngine

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    initializer :add_i18n_load_paths do |app|
      app.config.i18n.load_path += Dir[config.root.join("config/locales/**/**/", "*.{rb,yml}").to_s]
    end

    # Export our form objects to the APPS
    config.to_prepare do
      Dir.glob(File.join(Engine.root, "app/forms", "**/*.rb")).each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

  end
end
