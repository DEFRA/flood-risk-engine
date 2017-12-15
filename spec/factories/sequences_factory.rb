FactoryBot.define do
  sequence(:grid_reference) do |n|
    random_grid_reference + ("%05d" % n) + ("%05d" % n)
  end

  def random_grid_reference
    first = %w(N O S T).to_a.sample
    last = ("A".."Z").to_a.reject { |a| a == "I" }.sample
    [first, last].join
  end

  sequence(:random_email) { Faker::Internet.safe_email }
end
