module Gutsy
  module Cli
    class Generator
      extend Forwardable

      class State
        attr_reader :app_name
        attr_accessor :resources

        def initialize(app_name, resources=[])
          @app_name = app_name
          @resources = resources
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

      class ResourceState
        attr_reader :resource_name, :gem_name_pascal

        def initialize(resource_name, gem_name_pascal)
          @resource_name = resource_name
          @gem_name_pascal = gem_name_pascal
        end

        def twine
          binding
        end
      end

      attr_reader :app_name

      def initialize(app_name, schema_path, output_path)
        @state = State.new(app_name)
        @schema_path = schema_path
        @output_path = output_path
      end

      def generate!
        create_output_dir

        schema = load_and_validate_schema!

        state.resources = map_schema_to_resources(schema)

        scaffold_gem

        generate_heroics_client

        open_exe = find_executable("open") || find_executable("xdg-open")
        `#{open_exe} #{output_path}`
      end

      private

      attr_reader :state, :schema_path, :output_path
      attr_accessor :schema
      def_delegators :state, :app_name, :gem_name_snake, :gem_name_pascal

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

      def scaffold_gem
        print "Creating gem directory structure..."
        template_dirs.each do |dir|
          dir = dir.gsub('app_client', gem_name_snake)
          dir_path = File.join(output_path, dir)
          Dir.mkdir(dir_path, 0755) unless Dir.exist?(dir_path)
        end
        puts "OK"

        [
          ".gitignore",
          "Gemfile",
          "LICENSE.txt",
          "Rakefile",
          "README.md",
        ].each do |file|
          copy_file file
        end

        copy_file "app_client.gemspec",
                  as: "#{gem_name_snake}.gemspec"

        copy_file "lib/app_client.rb",
                  as: "lib/#{gem_name_snake}.rb"

        [
          "version.rb",
          "v1/adapter.rb"
        ].each do |file|
          copy_file "lib/app_client/#{file}",
                    as: "lib/#{gem_name_snake}/#{file}"
        end

        state.resources.each do |key, resource|
          copy_file "lib/app_client/v1/resource.rb",
                    as: "lib/#{gem_name_snake}/v1/#{key.to_s.underscore}.rb",
                    binding: ResourceState.new(key.to_s, gem_name_pascal).twine
        end
      end

      def generate_heroics_client
        print "Generating Heroics client for JSON Schema..."
        unless system "heroics-generate \
          #{gem_name_pascal}::V1::Adapters::Http \
          #{schema_path} \
          http://#{app_name.downcase}/api/v1 > \
          #{output_path}/lib/#{gem_name_snake}/v1/adapters/http.rb"
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
