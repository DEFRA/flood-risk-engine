# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe TransientPerson, type: :model do
    subject(:transient_person) { create(:transient_person) }
  end
end
