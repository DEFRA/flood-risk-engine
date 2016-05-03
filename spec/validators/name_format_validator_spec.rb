require "rails_helper"

module FloodRiskEngine
  RSpec.describe NameFormatValidator, type: :model do
    class NameValidatable
      include ActiveModel::Validations

      validates :name, "flood_risk_engine/name_format": true

      attr_accessor :name
    end

    let(:validatable) { NameValidatable.new }

    context "with valid name" do
      it "is valid" do
        validatable.name = "Joe Smith"

        expect(validatable.valid?).to be true
        expect(validatable.errors[:name].size).to eq(0)
      end

      # Different name Formats
      # http://www.w3.org/International/questions/qa-personal-names
      it do
        ["Björk Guðmundsdóttir", "Isa bin Osman", "Mao Ze Dong", "María-Jose Carreño Quiñones"].each do |n|
          validatable.name = n

          expect(validatable.valid?).to be true
          expect(validatable.errors[:name].size).to eq(0)
        end
      end
    end

    describe "Invalid" do
      it "with blank name is invalid" do
        expect(validatable.valid?).to be_falsey
        expect(validatable.errors[:name].size).to eq(1)
      end

      it " without 2 or more words  is invalid", duff: true do

        validatable.name ="    "
        expect(validatable.valid?).to be_falsey
        expect(validatable.errors[:name].size).to eq(1)

        validatable.name ="Mr "
        expect(validatable.valid?).to be_falsey
        expect(validatable.errors[:name].size).to eq(1)

        validatable.name =" Mr"
        expect(validatable.valid?).to be_falsey
        expect(validatable.errors[:name].size).to eq(1)

        validatable.name =" Mr "
        expect(validatable.valid?).to be_falsey
        expect(validatable.errors[:name].size).to eq(1)
      end

    end
  end
end
