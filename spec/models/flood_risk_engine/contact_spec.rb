require "rails_helper"

module FloodRiskEngine
  RSpec.describe Contact, type: :model do
    it { is_expected.to respond_to(:telephone_number) }
    it { is_expected.to have_one(:organisation).dependent(:restrict_with_exception) }
    it { is_expected.to have_one(:address).dependent(:restrict_with_exception) }
    it { is_expected.to define_enum_for(:title) }
    it { is_expected.to define_enum_for(:contact_type) }

    # context "Data" do
    #   it "should default title to n.a" do
    #     expect(DigitalServicesCore::Contact.new.title).to eq "na"
    #     expect(DigitalServicesCore::Contact.new.na?).to be true
    #     expect(DigitalServicesCore::Contact.new.Mr?).to be false
    #   end

    #   let(:contact) { create(:dsc_contact) }

    #   shared_examples_for "can parse a full name" do
    #     it "parses full name into first/last and back again as string" do
    #       contact.full_name = inbound
    #       expect(inbound).to eq contact.full_name
    #     end
    #   end

    # # Different name Formats
    # # http://www.w3.org/International/questions/qa-personal-names
    # it do
    #   ["E", "Björk Guðmundsdóttir", "Isa bin Osman", "Mao Ze Dong",
    #    "María-Jose Carreño Quiñones", "Dave", "John Q. Public", "Mr Pile ItUp"
    #   ].each do |n|
    #     is_expected.to allow_value(n).for(:full_name)
    #   end
    # end

    #   it "returns a full name as a string" do
    #     expect(
    #       contact.full_name
    #     ).to eq "#{contact.first_name} #{contact.last_name}"
    #   end
    # end
  end
end
