# encoding: UTF-8
require "rails_helper"

module FloodRiskEngine
  RSpec.describe "EnrollmentMailer submitted email", type: :mailer do
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    before(:all) do
      @recipient_address = "fred@example.com"
      @enrollment = create(:enrollment,
                           :with_correspondence_contact,
                           :with_secondary_contact,
                           status: Enrollment.statuses[:pending])
      @email = EnrollmentMailer.submitted(enrollment_id: @enrollment.id,
                                          recipient_address: @recipient_address)
    end

    def t(key)
      I18n.t(key, scope: "flood_risk_engine.enrollment_mailer.submitted")
    end

    it "generates a multipart message (plain text and html)" do
      expect(@email.body.parts.length).to eq(2)
      expect(@email.html_part).to_not be_nil
      expect(@email.text_part).to_not be_nil
    end

    let(:mail_yaml_key) { described_class.name.underscore.tr("/", ".") }

    it "renders the subject" do
      expect(@email.subject).to_not match(/translation missing/)
      expect(@email.subject).to eql(t(".subject"))
    end

    it "has the receiver's email" do
      expect(@email.to).to eql([@recipient_address])
    end

    it "has the sender's email" do
      # Note the configured sender might be in the format 'John Smith <js@gmail.com>'
      # So we expect a match on email address. Not that @email.from.first does not
      # return the Name part of the address - it will have been stripped out at this point.
      configured_sender = ENV["DEVISE_MAILER_SENDER"]
      expect(configured_sender).to be_present
      expect(configured_sender).to match(/#{@email.from.first}/)
    end

    describe "content" do
      it "has no missing translations" do
        expect(@email).to_not have_body_text(/translation missing/)
      end
    end

    context "content" do
      it "pulls in translated content" do
        %w(heading
           reference_number_heading
           preamble1
           preamble2
           preamble3
           summary_heading
           guidance.preamble
           guidance.link_title
           your_responsibilities.heading
           your_responsibilities.body).each do |key|
          expect(@email.text_part).to have_body_text(t(key))
          expect(@email.html_part).to have_body_text(t(key))
        end
      end

      it "reference_number" do
        expect(@email.text_part).to have_body_text(@enrollment.reference_number)
        expect(@email.html_part).to have_body_text(@enrollment.reference_number)
      end

      # TODO: once format of email is confirmed, add tests for enrollment/exemption-specific
      # content
    end
  end
end
