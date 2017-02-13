module Gutsy
  module Generator
    class GemState
      attr_reader :app_name, :base_url, :api_versions
      attr_accessor :resources

      def initialize(app_config)
        @app_name = app_config[:name]
        @api_versions = app_config[:versions]
        @base_url = app_config[:base_url]
        @resources = []
      end

      def gem_name
        @gem_name_snake ||= "#{app_name.underscore}_client"
      end

      def gem_name_snake
        gem_name
      end

      def gem_name_pascal
        @gem_name_pascal ||= gem_name.camelize(:upper)
      end

      def copyright_year
        @copyright_year ||= Time.now.year
      end

      def copyright_owner
        @copyright_owner ||= "YOUR_NAME_HERE"
      end

      def twine
        binding
      end
    end
  end
end