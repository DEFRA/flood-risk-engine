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

      describe "#new_address_path" do
        let(:path) do
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
          expect(path).to match(url)
        end

        it "should include addressable data" do
          escaped_contact_class = contact.class.to_s.gsub(":", "%3A")
          expect(path).to match(/addressable_type=#{escaped_contact_class}/)
          expect(path).to match(/addressable_id=#{contact.id}/)
        end

        it "should include postcode" do
          expect(path).to match(/postcode=S60\+1BY/)
        end

        it "should include address_type" do
          expect(path).to match(/address_type=#{address_type}/)
        end
      end

      describe "#change_postcode_path" do
        let(:steps) { WorkFlow::Definitions.start }
        let(:previous_step) { steps[1] }
        let(:step) { steps[2] }
        let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

        it "should give path to current step" do
          path = change_postcode_path(enrollment)
          expect(path).to eq(enrollment_step_path(enrollment, step))
        end

        it "should give path to previous step if step_back_to_postcode" do
          path = change_postcode_path(enrollment, step_back_to_postcode: true)
          expect(path).to eq(enrollment_step_path(enrollment, previous_step))
        end
      end
    end
  end
end
