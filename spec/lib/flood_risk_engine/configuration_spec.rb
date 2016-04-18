require "rails_helper"

module FloodRiskEngine
  describe Configuration do
    it "adds #config to the engine module" do
      expect(FloodRiskEngine).to respond_to(:config)
    end

    it "raises an error if a certain config value is not defined" do
      expect { FloodRiskEngine.config.missing_value }
        .to raise_error(NoMethodError)
    end
  end
end
