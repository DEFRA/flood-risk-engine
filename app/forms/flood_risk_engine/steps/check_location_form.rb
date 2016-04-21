# This simple null form over rides validate/save etc because there is no data to
# collect on this page
#
module FloodRiskEngine
  module Steps
    class CheckLocationForm < FloodRiskEngine::Steps::BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

      def save
        true
      end

      def validate(params)
        # Parameters: "check_location"=>{"location_check"=>"yes"}, "commit"=>"Continue"}
        unless params.key? :check_location
          errors.add(:base, t("errors.you_must_make_selection"))
          return false
        end

        true
      end
    end
  end
end
