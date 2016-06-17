require "rails_helper"

module FloodRiskEngine
  describe Configuration do
    subject { FloodRiskEngine.config }
    it 'adds #config to the engine module' do
      expect(FloodRiskEngine).to respond_to(:config)
    end

    it "raises an error if a certain config value is not defined" do
      expect { subject.missing_value }
        .to raise_error(NoMethodError)
    end

    it { is_expected.to respond_to(:layout) }
    it { is_expected.to respond_to(:minumum_dredging_length_in_metres) }
    it { is_expected.to respond_to(:maximum_dredging_length_in_metres) }
  end
end
