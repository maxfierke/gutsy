module Gutsy
  module Generator
    class GemState
      attr_reader :app_name, :base_url, :description

      def initialize(app_config)
        @app_name = app_config[:name]
        @base_url = app_config[:base_url]
        @description = app_config[:description]
        @app_config = app_config
      end

      def api_versions
        @api_versions ||= app_config[:versions].map do |api_version_config|
          Gutsy::Generator::ApiVersionState.new(api_version_config, self)
        end
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

      def gem_version
        @gem_version ||= app_config[:gem_version] || '0.1.0'
      end

      def copyright_year
        @copyright_year ||= Time.now.year
      end

      def copyright_owner
        @copyright_owner ||= author.name
      end

      def author
        @author ||= OpenStruct.new(author_config)
      end

      def twine
        binding
      end

      private

      attr_reader :app_config

      def author_config
        app_config[:author] || {
          name: "YOUR_NAME_HERE",
          email: "YOUR_EMAIL_ADDRESS",
          github: "GITHUB_USER"
        }
      end
    end
  end
end
