module Gutsy
  module Generator
    class ApiVersionState
      extend Forwardable

      attr_reader :name, :schema, :schema_path, :resource_url

      def_delegators :gem_state, :gem_name_pascal, :gem_name_snake, :app_name, :base_url

      def initialize(api_version_config, gem_state)
        @name = api_version_config[:name]
        @schema_path = api_version_config[:schema_path]
        @resource_url = api_version_config[:resource_url] || "api/#{@name.downcase}"
        @gem_state = gem_state
      end

      def module_name
        @module_name ||= name.upcase
      end

      def schema
        @schema ||= Gutsy::Schema.load_from_file!(schema_path)
      end

      def resources
        schema.resources
      end

      def twine
        binding
      end

      private

      attr_reader :gem_state
    end
  end
end
