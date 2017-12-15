require "rails_helper"

module FloodRiskEngine
  describe WorkFlow do
    let(:work_flow) { WorkFlow.new(:start) }
    let(:start_hash) { work_flow.make_hash(work_flow.work_flow) }
    let(:array) { %i[a b c d] }
    let(:hash) { { a: :b, b: :c, c: :d } }

    describe ".make_hash" do
      it "should convert an array into a hash" do
        expect(work_flow.make_hash(array)).to eq(hash)
      end
    end

    describe ".work_flow" do
      it "should be an Array" do
        expect(work_flow.work_flow).to be_a(Array)
      end

      it "should be Definitions start" do
        expect(work_flow.work_flow).to eq(WorkFlow::Definitions.start)
      end
    end

    describe ".to_hash" do
      it "should return hash for Definition start" do
        expect(work_flow.to_hash).to eq(start_hash)
      end
    end

    describe "#for" do
      it "should hash for Definition start array" do
        expect(WorkFlow.for(:start)).to eq(start_hash)
      end
    end
  end
end
