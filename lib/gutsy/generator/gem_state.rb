module Gutsy
  module Generator
    class State
      attr_reader :app_name, :api_versions
      attr_accessor :resources

      def initialize(app_name, api_versions)
        @app_name = app_name
        @api_versions = api_versions
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