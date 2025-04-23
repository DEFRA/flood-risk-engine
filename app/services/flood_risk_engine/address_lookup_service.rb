# frozen_string_literal: true

module FloodRiskEngine
  class AddressLookupService < BaseService
    delegate :run, to: :"DefraRuby::Address::EaAddressFacadeV11Service"
  end
end
