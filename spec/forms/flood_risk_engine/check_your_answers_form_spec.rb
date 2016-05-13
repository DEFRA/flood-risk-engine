require "rails_helper"

module FloodRiskEngine
  module Steps
    RSpec.describe Steps::CheckYourAnswersForm, type: :form do
      let(:enrollment) { build_stubbed(:enrollment, token: "123") }
      let(:params_key) { :check_your_answers }
      let(:model_class) { Enrollment }
      subject { described_class.factory(enrollment) }

      it_behaves_like "a form object"
      it { is_expected.to be_a(described_class) }

      describe "#rows" do
        it {
          expect(subject.rows).to be_a(Array)
        }
      end
    end
  end
end
