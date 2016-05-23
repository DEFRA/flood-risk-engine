require "rails_helper"
module FloodRiskEngine
  module Enrollments
    describe AddressesHelper do
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:postcode) { "S60 1BY" }
      let(:contact) { FactoryGirl.create(:contact) }
      let(:address_type) { :contact }
      let(:label) { "Link to new address" }

      include FloodRiskEngine::Engine.routes.url_helpers

      describe "#new_address_link" do
        let(:link) do
          new_address_path(
            enrollment: enrollment,
            addressable: contact,
            postcode: postcode,
            address_type: address_type
          )
        end

        it "should include the new address path" do
          url = new_enrollment_address_path(
            enrollment
          )
          expect(link).to match(url)
        end

        it "should include addressable data" do
          escaped_contact_class = contact.class.to_s.gsub(":", "%3A")
          expect(link).to match(/addressable_type=#{escaped_contact_class}/)
          expect(link).to match(/addressable_id=#{contact.id}/)
        end

        it "should include postcode" do
          expect(link).to match(/postcode=S60\+1BY/)
        end

        it "should include address_type" do
          expect(link).to match(/address_type=#{address_type}/)
        end
      end
    end
  end
end
