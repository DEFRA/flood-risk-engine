# frozen_string_literal: true

require "dibber"
# https://github.com/reggieb/Dibber
Seeder = Dibber::Seeder
Seeder.seeds_path = File.expand_path("seeds", File.dirname(__FILE__))

# Note that if an Exemptions exists seeding will just update the summary
Seeder.seed(
  FloodRiskEngine::Exemption,
  name_method: :code,
  attributes_method: :summary,
  overwrite: true
)

["Seeding complete", Seeder.report].flatten.each { |m| Rails.logger.info m }
