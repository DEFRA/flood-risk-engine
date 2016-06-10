module FloodRiskEngine
  # Simple cipher encoding from
  # http://stackoverflow.com/questions/4128939/simple-encryption-in-ruby-without-external-gems
  module SimpleEncoding

    protected

    def encode(text)
      return "" unless text.present?
      text.tr(characters, encoding)
    end

    def decode(text)
      return "" unless text.present?
      text.tr(encoding, characters)
    end

    def characters
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    end

    def encoding
      "N8nGfS1rpcHvmoiP6WB9FMQwXjyZ0Rhu73stKAla2Yd4LTJqkeUzgEOxbCD5VI"
    end
  end
end
