module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"
  end
end
