
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

    # Automatically add our migrations into the main apps migrations
    # As the services provided by core grows we may want to stop this
    # and add generators that copy specific migrations over

    initializer :append_migrations, before: :load_config_initializers do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end


    # Export our form objects to the APPS
    config.to_prepare do
      Dir.glob(File.join(Engine.root, "app/forms", "**/*.rb")).each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

  end
end
