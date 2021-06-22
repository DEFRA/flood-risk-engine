# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration, type: :model do
    subject(:new_registration) { create(:new_registration) }

    it_behaves_like "a transient_registration", :new_registration

    it "subclasses TransientRegistration" do
      expect(described_class).to be < TransientRegistration
    end
  end
end
