# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  describe Configuration do
    subject(:engine_config) { FloodRiskEngine.config }

    it "adds #config to the engine module" do
      expect(FloodRiskEngine).to respond_to(:config)
    end

    it "raises an error if a certain config value is not defined" do
      expect { engine_config.missing_value }
        .to raise_error(NoMethodError)
    end

    it { is_expected.to respond_to(:layout) }
    it { is_expected.to respond_to(:minimum_dredging_length_in_metres) }
    it { is_expected.to respond_to(:maximum_dredging_length_in_metres) }

    it "configures Companies House API properties" do
      companies_house_configuration = DefraRuby::CompaniesHouse::Configuration.new

      allow(DefraRuby::CompaniesHouse).to receive(:configure).and_yield(companies_house_configuration)

      config = described_class.new
      config.companies_house_host = "https://example.com"
      config.companies_house_api_key = "api-key"

      expect(companies_house_configuration.companies_house_host).to eq("https://example.com")
      expect(companies_house_configuration.companies_house_api_key).to eq("api-key")
    end
  end
end
