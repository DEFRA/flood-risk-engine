require "rails_helper"

module FloodRiskEngine
  RSpec.describe ReferenceNumber do
    let(:parameters) { {} }
    let(:reference_number) { described_class.new(parameters) }

    describe "#with" do
      let(:seed) { 50 }
      let(:offset) { 100 }
      let(:minimum_length) { 8 }
      let(:padding) { "x" }
      let(:prefix) { "foo" }
      let(:parameters) do
        {
          seed: seed,
          offset: offset,
          minimum_length: minimum_length,
          padding: padding,
          prefix: prefix
        }
      end

      it "should return 'fooxx150'" do
        expect(described_class.with(parameters)).to eq("fooxx150")
      end
    end

    describe ".number" do
      it "should return an empty string" do
        expect(reference_number.number).to eq("")
      end

      context "with seed" do
        let(:seed) { 1 }
        let(:parameters) { { seed: seed } }

        it "should return the seed as a string" do
          expect(reference_number.number).to eq(seed.to_s)
        end

        context "and prefix" do
          let(:prefix) { "foo" }
          let(:parameters) { { seed: seed, prefix: prefix } }

          it "should add prefix to start of seed" do
            expect(reference_number.number).to eq(prefix + seed.to_s)
          end
        end

        context "and offset" do
          let(:offset) { 100 }
          let(:parameters) { { seed: seed, offset: offset } }

          it "should add offset to seed" do
            expect(reference_number.number).to eq((seed + offset).to_s)
          end
        end

        context "and minimum length and padding" do
          let(:minimum_length) { 5 }
          let(:padding) { "x" }
          let(:parameters) do
            {
              seed: seed,
              minimum_length: minimum_length,
              padding: padding
            }
          end

          it "should add offset to seed" do
            count = minimum_length - seed.to_s.length
            expect(reference_number.number).to eq((padding * count) + seed.to_s)
          end

          context "but with a long seed" do
            let(:seed) { 10**(minimum_length + 1) }

            it "should just return the number" do
              expect(reference_number.number).to eq(seed.to_s)
            end
          end
        end
      end

      context "with minimum length and padding" do
        let(:minimum_length) { 5 }
        let(:padding) { "x" }
        let(:parameters) do
          {
            minimum_length: minimum_length,
            padding: padding
          }
        end

        it "should add offset to seed" do
          expect(reference_number.number).to eq(padding * minimum_length)
        end
      end
    end

    describe "#new" do
      context "with minimum length and no padding" do
        let(:minimum_length) { 5 }
        let(:parameters) { { minimum_length: minimum_length } }

        it "should raise error" do
          msg = "A :padding must be specified with a :minimum_length"
          expect { reference_number }.to raise_error(msg)
        end
      end
    end
  end
end
