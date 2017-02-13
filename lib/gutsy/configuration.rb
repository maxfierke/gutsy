module Gutsy
  class Configuration
    def self.load_from_file!(config_file_path)
      yaml_config = YAML.load_file(config_file_path).deep_symbolize_keys
      raise "Not a valid gutsy configration file" unless yaml_config[:gutsy]
      new(yaml_config[:gutsy])
    end

    def initialize(config)
      @config = config
    end

    def [](application_key)
      @config[application_key]
    end

    def apps
      @config.values
    end
  end
end
