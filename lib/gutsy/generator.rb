require 'gutsy/generator/gem_state'
require 'gutsy/generator/resource_state'

module Gutsy
  module Cli
    class Generator
      extend Forwardable

      def initialize(app_name, schema_path, output_path, api_versions)
        @state = Gutsy::Generator::State.new(app_name, api_versions)
        @schema_path = schema_path
        @output_path = output_path
      end

      def generate!
        create_output_dir

        schema = load_and_validate_schema!

        state.resources = map_schema_to_resources(schema)

        build_gem

        puts "Generated client gem can be found in... #{output_path}"
      end

      private

      attr_reader :state, :schema_path, :output_path
      attr_accessor :schema
      def_delegators :state, :app_name, :gem_name_snake, :gem_name_pascal, :api_versions

      def create_output_dir
        print "Creating #{output_path}..."
        Dir.mkdir(output_path, 0755) unless Dir.exist?(output_path)
        puts "OK"
      end

      def load_and_validate_schema!
        print "Validating schema against draft-04 JSON Schema..."
        draft04_uri = URI.parse("http://json-schema.org/draft-04/hyper-schema")
        draft04 = JsonSchema.parse!(JSON.parse(draft04_uri.read))

        schema_json = JSON.parse(File.read(schema_path))

        schema = JsonSchema.parse!(schema_json)
        schema.expand_references!

        draft04.validate!(schema)
        puts "OK"

        schema
      end

      def map_schema_to_resources(schema)
        resources = Hash[schema.definitions.map do |key, resource|
          links = Hash[resource.links.map do |link|
            link.schema.expand_references! if link.schema
            properties = link.schema.try(:properties) || {}
            [link.title.downcase.to_sym, OpenStruct.new(properties: properties)]
          end]
          [key.to_sym, OpenStruct.new(title: key.camelize, links: links)]
        end]
        resources
      end

      def build_gem
        print "Creating gem directory structure..."
        build_gem_directory_tree
        puts "OK"

        print "Creating gem metadata..."
        generate_gem_metadata
        puts "OK"

        print "Generating API clients for each API version..."
        generate_api_clients
        puts "OK"
      end

      def build_gem_directory_tree
        template_dirs.flat_map do |dir|
          dir = dir.gsub('app_client', gem_name_snake)
          if dir =~ /api_version/
            state.api_versions.map { |v| dir.gsub('api_version', v) }
          else
            [dir]
          end
        end.each do |dir|
          dir_path = File.join(output_path, dir)
          Dir.mkdir(dir_path, 0755) unless Dir.exist?(dir_path)
        end
      end

      def generate_gem_metadata
        [
          ".gitignore",
          "Gemfile",
          "LICENSE.txt",
          "Rakefile",
          "README.md",
        ].each do |file|
          copy_file file
        end

        copy_file "app_client.gemspec", as: "#{gem_name_snake}.gemspec"
        copy_file "lib/app_client.rb", as: "lib/#{gem_name_snake}.rb"
        copy_file "lib/app_client/version.rb", as: "lib/#{gem_name_snake}/version.rb"
      end

      def generate_api_clients
        api_versions.each do |api_version|
          module_name = api_version.upcase

          copy_file "lib/app_client/api_version/adapter.rb",
                    as: "lib/#{gem_name_snake}/#{api_version}/adapter.rb",
                    binding: Gutsy::Generator::ResourceState.new(nil, module_name, state).twine

          state.resources.each do |key, resource|
            copy_file "lib/app_client/api_version/resource.rb",
                      as: "lib/#{gem_name_snake}/#{api_version}/#{key.to_s.underscore}.rb",
                      binding: Gutsy::Generator::ResourceState.new(key.to_s, module_name, state).twine
          end

          generate_heroics_client(api_version)
        end
      end

      def generate_heroics_client(api_version)
        print "Generating Heroics client for #{api_version} JSON Schema..."
        unless system "heroics-generate \
          #{gem_name_pascal}::#{api_version.upcase}::Adapters::Http \
          #{schema_path} \
          http://#{app_name.downcase}/api/#{api_version.downcase} > \
          #{output_path}/lib/#{gem_name_snake}/#{api_version.downcase}/adapters/http.rb"
          puts "FAIL"
          puts "Please see stacktrace or heroics errors"
        end
        puts "OK"
      end

      # Derived from Methadone::Cli (https://github.com/davetron5000/methadone/blob/935444f9deb81100a33ec3234effbeb65acbc080/lib/methadone/cli.rb)
      def copy_file(relative_path,options = {})
        relative_path = File.join(relative_path.split(/\//))

        template_path = File.join(template_dir, "#{relative_path}.erb")
        template = ERB.new(File.read(template_path), nil, '-')

        output_relative_path ||= options[:as] || relative_path

        file_output_path = File.join(output_path, output_relative_path)

        print "Copying #{file_output_path}..."

        erb_binding = options[:binding] || state.twine

        File.open(file_output_path, 'w') do |file|
          file.puts template.result(erb_binding)
          file.chmod(0755) if options[:executable]
        end

        print "OK\n"
      end

      def template_dir
        @template_dir ||= File.join(File.dirname(__FILE__), '..', '..', 'templates', 'app_client')
      end

      def template_dirs
        Dir["#{template_dir}/**/*"].
          select { |x| File.directory? x }.
          map { |dir| dir.gsub(/^#{template_dir}\//,'') }
      end
    end
  end
end
