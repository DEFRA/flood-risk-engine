require "rails_helper"

module EA

  RSpec.describe Validators::CompaniesHouseNumberValidator do
    class ACompanyClass
      include ActiveModel::Model
      include ActiveModel::Validations

      attr_accessor :number
      validates :number, "ea/validators/companies_house_number": { allow_blank: true }
    end

    subject { ACompanyClass.new(number: number) }

    context "when the number is valid in 8 digit format" do
      let(:number) { "CH123456" }
      it { is_expected.to be_valid }
    end

    context "when the number is valid in 2 chars + 6 digit format" do
      let(:number) { "12345678" }
      it { is_expected.to be_valid }
    end

    context "when the number is not 8 digits" do
      %w[1234567 123456789].each do |invalid_number|
        let(:number) { invalid_number }
        it { is_expected.to_not be_valid }
      end
    end

    context "when the number sis not 2 chars + 6 digits" do
      %w[ZZ12345 AA1234567].each do |invalid_number|
        let(:number) { invalid_number }
        it { is_expected.to_not be_valid }
      end
    end
    context "when the number has leading and trailing whitespace" do
      let(:number) { "  XX123456  " }
      it "trims whitespace before validating and leaves it trimmed" do
        expect(subject).to be_valid
        expect(subject.number).to eq number.strip
      end
    end
  end

end
