# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Comment do
    let(:comment) { create(:comment) }

    it "can be associated with enrollment exemptions" do
      expect(comment.commentable.class).to eq(EnrollmentExemption)
    end
  end
end
