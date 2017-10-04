module Gutsy
  module Generator
    class Heroics
      def self.generate(api_version_state, output_path)
        new(api_version_state, output_path).generate
      end

      def initialize(api_version_state, output_path)
        @api_version_state = api_version_state
        @output_path = output_path
      end

      def generate
        system "heroics-generate \
          #{module_name} \
          #{api_version_state.schema_path} \
          #{api_url} > \
          #{client_output_path}"
      end

      private

      attr_reader :api_version_state, :output_path

      def module_name
        @module_name ||= "#{api_version_state.gem_name_pascal}::#{api_version_state.module_name}::Adapters::Http"
      end

      def api_url
        @api_url ||= "#{api_version_state.base_url}/#{api_version_state.resource_url}"
      end

      def client_output_path
        @client_output_path ||= "#{output_path}/lib/#{api_version_state.gem_name_snake}/#{api_version_state.name.downcase}/adapters/http.rb"
      end
    end
  end
end
