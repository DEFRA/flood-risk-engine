require "rails_helper"

module FloodRiskEngine
  module Enrollments
    RSpec.describe AddressForm, type: :form do
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:address) { FactoryGirl.create(:address) }

      subject { described_class.new(enrollment, address) }

      it { is_expected.to be_a(described_class) }

      it do
        is_expected.to validate_presence_of(:premises)
          .with_message(t(".errors.premises.blank"))
      end
      it do
        is_expected.to validate_presence_of(:street_address)
          .with_message(t(".errors.street_address.blank"))
      end
      it do
        is_expected.to validate_presence_of(:city)
          .with_message(t(".errors.city.blank"))
      end

      it { is_expected.to validate_length_of(:premises) }
      it { is_expected.to validate_length_of(:street_address) }
      it { is_expected.to validate_length_of(:locality) }
      it { is_expected.to validate_length_of(:city) }

      describe "#save" do
        it "should save the address" do
          city = "foo"
          subject.validate(
            address: { city: city }
          )
          subject.save
          expect(address.reload.city).to eq(city)
        end
      end

      def t(locale, args = {})
        super "flood_risk_engine.enrollments.addresses#{locale}", args
      end
    end
  end
end
