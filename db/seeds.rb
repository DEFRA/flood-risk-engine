require 'dibber'
# https://github.com/reggieb/Dibber
Seeder = Dibber::Seeder
Seeder.seeds_path = File.expand_path('seeds', File.dirname(__FILE__))

# Note that if an Exemptions exists seeding will just update the summary
Seeder.new(
  FloodRiskEngine::Exemption,
  'flood-risk-engine/exemptions.yml',
  name_method: :code,
  attributes_method: :summary
).build

puts Seeder.report


