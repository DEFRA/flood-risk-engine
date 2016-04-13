# We have attempted to make seeding flexible depending on the environment the seed is occuring. This allows us to,
# for example add dummy records into a User Testing or staging environment that we wouldn't want in development. This
# works by having a file for each environment within db/seeds which handles anything specific to that environment.
# Anything that is mutual to all goes in db/seeds/all.rb. db/seeds.rb then simply becomes a function that calls all.rb
# and the relevant environment specific file. This solution and the code below were taken from
# https://archive.dennisreimann.de/blog/seeds-for-different-environments/
["all", Rails.env].each do |seed|
  seed_file = FloodRiskEngine::Engine.root.join("db", "seeds", "#{seed}.rb")
  if File.exists?(seed_file)
    puts "FRE:SEED MSG: Loading #{seed} data"
    require seed_file
  end
end
