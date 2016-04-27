require "rails_helper"

module FloodRiskEngine
  RSpec.describe NameFormatValidator, type: :model do

    class Validatable
      include ActiveModel::Validations

      validates :name, "flood_risk_engine/name_format": true

      attr_accessor  :name
    end

    let(:validatable) { Validatable.new }

    context 'with valid name' do
      it 'is valid' do
        validatable.name = Faker::Company.name

        expect(validatable.valid?).to be true
        expect(validatable.errors[:name].size).to eq(0)
      end
    end

    describe "Invalid" do

      context 'without name' do
        it 'is invalid' do
          expect(validatable.valid?).to be_falsey
          expect(validatable.errors[:name].size).to eq(1)
        end
      end

      context 'with invalid charcters' do
        it 'is invalid' do
          validatable.name = Faker::Company.name + " 12 * &"

          expect(validatable.valid?).to be_falsey
          expect(validatable.errors[:name].size).to eq(1)
        end
      end
    end
  end
end

