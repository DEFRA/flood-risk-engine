require "rails_helper"

# Example feature spec
RSpec.describe "Step 1" do
  it "renders correctly" do
    enrollment = FloodRiskEngine::Enrollment.create(step: :grid_reference)
    url = flood_risk_engine.enrollment_step_path(enrollment, :grid_reference)

    # Not using page objects yet but see readme in spec/support/page_objects dir
    # page_object = FloodRiskEngine::PageObjects::Steps::NewStructurePage.new
    # page_object.visit_page
    # page_object.new_structure = 'yes'

    visit url

    expect(page.current_path).to eq(url)

    # other things to test
    # - header text matches what's in i18n
    # - submit with no date generates validation error on the page
    # - submit with invalid date generates validation error on the page
    # - submit with valid data take you on to next step
  end
end
