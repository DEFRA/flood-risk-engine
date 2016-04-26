require "rails_helper"

RSpec.describe WasteExemptionsShared::GridReferenceValidator, type: :model do
  let(:address) { DigitalServicesCore::Address.new }

  let(:valid_grid_ref) { "ST 12345 12345" }

  before(:each) do
    address.build_location
  end

  it "fills address errors when grid reference length invalid" do
    address.location.grid_reference = "ST"

    WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

    expect(address.location.errors).to_not be_empty
    expect(address.valid?).to eq false

    text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.grid_reference.length",
                  list:  WasteExemptionsShared::GridReferenceValidator.grid_ref_valid_lengths.inspect)

    expect(address.location.errors[:grid_reference]).to include text
  end

  ["12345 12345 ST", "S 12345 12345 T", "ST 12A 111.3.+", "ST 12345*78**"].each do |format|
    it "fills address errors when grid reference format #{format} is invalid" do
      address.location.grid_reference = format

      WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

      expect(address.location.errors).to_not be_empty
      expect(address.valid?).to eq false

      text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.grid_reference.invalid")
      expect(address.location.errors[:grid_reference]).to include text
    end
  end

  it "fills address errors when grid reference  but no site info" do
    address.location.grid_reference = valid_grid_ref

    WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

    expect(address.location.errors).to_not be_empty
    expect(address.valid?).to eq false

    expect(address.location.errors[:grid_reference]).to be_empty

    text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.site_info.blank")
    expect(address.location.errors[:site_info]).to include text
  end

  it "a grid reference site info has a min length" do
    address.location.grid_reference = valid_grid_ref
    address.location.site_info = "a"

    WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

    expect(address).to_not be_valid
    expect(address.location.errors[:site_info].size).to eq(1)

    # this one form does not seem to be picked up by Rails - no show stopper!
    #text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.site_info.too_short.one")

    text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.site_info.too_short.other",
                  count:  WasteExemptionsShared::GridReferenceValidator.site_info_min_length)

    expect(address.location.errors[:site_info]).to include text

    address.location.site_info = "ab"

    WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

    text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.site_info.too_short.other",
                  count:  WasteExemptionsShared::GridReferenceValidator.site_info_min_length)
    expect(address.location.errors[:site_info]).to include text
  end

  it "a grid reference site info has a max length " do
    address.location.grid_reference = valid_grid_ref
    address.location.site_info = "ab" * WasteExemptionsShared::GridReferenceValidator.site_info_max_length

    WasteExemptionsShared::GridReferenceValidator.new(address.location).validate

    expect(address).to_not be_valid
    expect(address.location.errors[:site_info].size).to eq(1)

    text = I18n.t("activerecord.errors.models.digital_services_core/location.attributes.site_info.too_long.other",
                  count:  WasteExemptionsShared::GridReferenceValidator.site_info_max_length)
    expect(address.location.errors[:site_info]).to include text
  end
end
