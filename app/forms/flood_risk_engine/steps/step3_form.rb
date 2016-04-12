module FloodRiskEngine
  module Steps
    class Step3Form < BaseForm
      property :dummy_string2
      validates :dummy_string2, presence: true

      def self.factory(enrollment)
        new(enrollment)
      end

      def validate(params)
        super params[:step3]
      end
    end
  end
end
