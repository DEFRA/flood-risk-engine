module FloodRisk
  module PageObjects
    module Steps
      class NewStructurePage
        include Capybara::DSL

        module Selectors
          RADIO = "css_selector".freeze
        end

        def visit_page
          visit flood_risk.root_path
          self
        end

        def new_structure=(yes_or_no)
          choose(Selectors::RADIO, option: yes_or_no)
        end

        def submit
          raise "Not impl yet"
        end

      end
    end
  end
end
