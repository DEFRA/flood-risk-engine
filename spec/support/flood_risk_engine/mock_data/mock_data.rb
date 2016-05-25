module FloodRiskEngine
  class MockData

    def initialize(file_name)
      @file_name = file_name.to_s.strip
    end

    def file_name
      return @file_name if @file_name =~ /\.yml$/
      "#{@file_name}.yml"
    end

    def path
      File.expand_path file_name, File.dirname(__FILE__)
    end

    def yaml
      @yaml ||= YAML.load_file path
    end

    def data_for(key)
      yaml[key.to_s]
    end

  end
end
