# encoding: UTF-8
require "rails_helper"

module FloodRiskEngine
  RSpec.describe "EnrollmentMailer submitted email", type: :mailer do
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    let(:initial_status) { :building }
    let(:enrollment_exemption) do
      FactoryGirl.create(
        :enrollment_exemption,
        status: EnrollmentExemption.statuses[initial_status]
      )
    end
    let(:enrollment) do
      FactoryGirl.create(
        :enrollment,
        enrollment_exemptions: [enrollment_exemption],
        reference_number: ReferenceNumber.create
      )
    end
    let(:recipient_address) { Faker::Internet.safe_email }
    let(:email) do
      EnrollmentMailer.submitted(
        enrollment_id: enrollment.id,
        recipient_address: recipient_address
      )
    end

    def t(key)
      I18n.t(key, scope: "flood_risk_engine.enrollment_mailer.submitted")
    end

    it "generates a multipart message (plain text and html)" do
      expect(email.body.parts.length).to eq(2)
      expect(email.html_part).to_not be_nil
      expect(email.text_part).to_not be_nil
    end

    let(:mail_yaml_key) { described_class.name.underscore.tr("/", ".") }

    it "renders the subject" do
      expect(email.subject).to_not match(/translation missing/)
      expect(email.subject).to eql(t(".subject"))
    end

    it "has the receiver's email" do
      expect(email.to).to eql([recipient_address])
    end

    it "has the sender's email" do
      # Note the configured sender might be in the format 'John Smith <js@gmail.com>'
      # So we expect a match on email address. Not that @email.from.first does not
      # return the Name part of the address - it will have been stripped out at this point.
      configured_sender = ENV["DEVISE_MAILER_SENDER"]
      expect(configured_sender).to be_present
      expect(configured_sender).to match(/#{email.from.first}/)
    end

    describe "content" do
      it "has no missing translations" do
        expect(email).to_not have_body_text(/translation missing/)
      end
    end

    context "content" do
      context "in html format" do
        %w(subject
           registration_submitted
           please_wait
           exemption_heading
           heading_1
           preamble_1a
           preamble_1b
           heading_2
           preamble_2
           heading_3
           preamble_3_html
           contact_heading
           contact_email_html
           contact_telephone_html
           contact_minicom_html
           contact_opening_hours).each do |key|
          it "pulls in translated content for .#{key}" do
            expect(email.html_part).to have_body_text(t(key))
          end
        end
      end
      context "in text format" do
        %w(registration_submitted
           please_wait
           exemption_heading
           heading_1
           preamble_1a
           preamble_1b
           heading_2
           preamble_2
           heading_3
           preamble_3a
           preamble_3b
           contact_heading
           contact_email
           contact_telephone
           contact_minicom
           contact_opening_hours).each do |key|
          it "pulls in translated content for .#{key}" do
            expect(email.text_part).to have_body_text(t(key))
          end
        end
      end

      it "reference_number" do
        expect(email.text_part).to have_body_text(enrollment.reference_number)
        expect(email.html_part).to have_body_text(enrollment.reference_number)
      end

      # TODO: once format of email is confirmed, add tests for enrollment/exemption-specific
      # content
    end
  end
end
