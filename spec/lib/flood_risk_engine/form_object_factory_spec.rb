require "rails_helper"

module FloodRiskEngine
  describe Steps::FormObjectFactory do
    let!(:factory) { Steps::FormObjectFactory }

    let!(:enrollment) { Enrollment.new }

    it "anables us to find the FormObject for a defined Step" do
      expect(factory).to respond_to(:form_object_for)
    end

    it "raises an error if a certain config value is not defined" do
      expect { factory.form_object_for(:blah_step_nonsense, enrollment) }.to raise_error(FormObjectError)
    end

    it "returns a form Object for a valid step", duff: true do
      expect(factory.form_object_for(Enrollment.new.current_step.to_sym, enrollment)).to be_a Steps::BaseForm
    end

    it "returns a form Object for a valid step" do
      expect(factory.form_object_for(Enrollment.new.current_step.to_s, enrollment)).to be_a Steps::BaseForm
    end
  end
end
