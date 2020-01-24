# frozen_string_literal: true

module WasteExemptionsEngine
  class BaseService
    def self.run(attrs = nil)
      if attrs
        new.run(attrs)
      else
        new.run
      end
    end
  end
end
