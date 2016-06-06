require "rails_helper"

module EA

  RSpec.describe Validators::CompaniesHouseNameValidator do
    class NameValidatable
      include ActiveModel::Model
      include ActiveModel::Validations

      attr_accessor :name
      validates :name, 'ea/validators/companies_house_name': true
    end

    subject { NameValidatable.new(name: name) }

    describe "Valid entry" do
      after(:each) do
        is_expected.to be_valid
        expect(subject.errors[:name].size).to eq(0)
      end

      context "With just normal chars" do
        let(:name) { "Joe Bloggs 123456 Ltd" }
        it "is valid" do end
      end

      context "With just numbers" do
        let(:name) { "123456" }
        it "is valid" do  end
      end

      context "With special but allowed chars" do
        let(:name) { "Joe @ Bloggs 123&456 * Ltd %$£" }
        it "is valid" do end
      end

      context "With only a single special char" do
        let(:name) { "@" }
        it "is valid" do end
      end

      context "With only multiple special chara" do
        let(:name) { "@ $$" }
        it "is valid" do end
      end
    end

    describe "Disallowed special chars" do
      Validators::CompaniesHouseNameValidator.disallowed_chars.each do |char|
        context "when the name starts with #{char}" do
          let(:name) { "#{char}Joe Bloggs Ltd" }
          it "is invalid" do
            is_expected.to_not be_valid
            expect(subject.errors[:name].size).to eq(1)
          end
        end

        context "when the name contain #{char}" do
          let(:name) { "Joe Bloggs#{char} Ltd" }
          it "is invalid" do
            is_expected.to_not be_valid
            expect(subject.errors[:name].size).to eq(1)
          end
        end

        context "when the name ends with #{char}" do
          let(:name) { "Joe Bloggs Ltd#{char}" }
          it "is invalid" do
            is_expected.to_not be_valid
            expect(subject.errors[:name].size).to eq(1)
          end
        end
      end
    end
  end
end
