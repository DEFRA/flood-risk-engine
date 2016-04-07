require "rails_helper"

RSpec.describe "'New structure?' step" do
  # This is just a placeholder to check feature specs are working and we can hit the root
  # url. Delete later.
  it "TODO" do
    visit flood_risk_engine.root_path
    # template
    #expect(page).to have_...

    # page_object = FloodRisk::PageObjects::Steps::NewStructurePage.new
    # page_object.new_structure = 'yes'

    # creates enrollment and redirects to #edit
    #expect(page.current_path).to eq(flood_risk_engine.edit_enrollment_path)
    # .. but this will actually create the enrollment, then redirect to edit
    # so here we need to load the enrollment so we can check we have gone to the
    # right route.
    # Could do this by looking a the current url for the enrollment id/token
    # That might be something we need to do on each page
    # So if we are going to use page objects, http://martinfowler.com/bliki/PageObject.html
    # which I think is a good idea,
    # a base page object could have a method that derives the enrollment id/token and
    # loads the enrollment and returns it?
  end
end
