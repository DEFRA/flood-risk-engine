
# Get the seed text from locale files

codes = I18n.t('.enrollments.states.add_exemptions.code')
desc  = I18n.t('.enrollments.states.add_exemptions.summary')

unless(codes.is_a?(Hash) && desc.is_a?(Hash))
  puts "ERROR - Expecting Exemptions seed data in locale key : '.enrollments.states.add_exemptions' + code & summary"
  puts "GOT", codes.inspect, desc.inspect
  Kernel.abort("ABORT : Missing locale information for seeding Exemptions")
end

FloodRiskEngine::Exemption.delete_all unless(Rails.env.production?)

puts "Seeding Exemptions from locale data"

codes = I18n.t('.enrollments.states.add_exemptions.code').values
desc  = I18n.t('.enrollments.states.add_exemptions.summary').values

codes.each_with_index do |c, i|
  FloodRiskEngine::Exemption.create(code: c,
                   summary: desc[i], description: desc[i],
                   valid_from: Time.zone.now,  valid_to: nil,
                   url: "TBD"
  )
end

puts "DONE - Seeding Exemptions"
