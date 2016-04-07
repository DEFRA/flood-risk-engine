module FloodRiskEngine
  module Steps
    class Step2Form < BaseForm
      property :dummy_string1
      validates :dummy_string1, presence: true

      def self.factory(enrollment)
        new(enrollment) # for now
      end

      def validate(params)
        super params[:step2]
      end
    end
  end
end
