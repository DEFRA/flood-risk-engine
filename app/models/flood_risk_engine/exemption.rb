module FloodRiskEngine
  class Exemption < ActiveRecord::Base
    default_scope { order("CAST(#{table_name}.code AS int)") }

    has_many :enrollment_exemptions,
             dependent: :restrict_with_exception
    has_many :enrollments,
             through: :enrollment_exemptions,
             dependent: :restrict_with_exception

    enum category: {
    }

    # An exemption's friendly name, used for example when listing exemptions in an email.
    def to_s
      "#{code}: #{summary}"
    end
  end
end
