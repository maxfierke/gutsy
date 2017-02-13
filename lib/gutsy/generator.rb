require 'gutsy/generator/gem_state'
require 'gutsy/generator/resource_state'

module Gutsy
  module Cli
    class Generator
      extend Forwardable

      def initialize(app_config, output_path)
        @state = Gutsy::Generator::GemState.new(app_config)
        @output_path = output_path
      end

      def generate!
        create_output_dir

        build_gem

        puts "Generated client gem(s) can be found in... #{output_path}"
      end

      private

      attr_reader :state, :output_path
      def_delegators :state, :app_name, :gem_name_snake, :gem_name_pascal, :api_versions

      def create_output_dir
        print "Creating #{output_path}..."
        Dir.mkdir(output_path, 0755) unless Dir.exist?(output_path)
        puts "OK"
      end

      def load_and_validate_schema!(schema_path)
        print "Validating schema against draft-04 JSON Schema..."
        schema = Gutsy::Schema.load_from_file!(schema_path)
        puts "OK"

        schema
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
            state.api_versions.map { |v| dir.gsub('api_version', v[:name]) }
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
          version_name = api_version[:name]
          schema_path = api_version[:schema_path]
          module_name = version_name.upcase

          schema = load_and_validate_schema!(schema_path)

          copy_file "lib/app_client/api_version/adapter.rb",
                    as: "lib/#{gem_name_snake}/#{version_name}/adapter.rb",
                    binding: Gutsy::Generator::ResourceState.new(nil, module_name, state).twine

          schema.resources.each do |key, resource|
            copy_file "lib/app_client/api_version/resource.rb",
                      as: "lib/#{gem_name_snake}/#{version_name}/#{key.to_s.underscore}.rb",
                      binding: Gutsy::Generator::ResourceState.new(key.to_s, module_name, state).twine
          end

          generate_heroics_client(api_version)
        end
      end

      def generate_heroics_client(api_version)
        version_name = api_version[:name]
        print "Generating Heroics client for #{version_name} JSON Schema..."
        unless system "heroics-generate \
          #{gem_name_pascal}::#{version_name.upcase}::Adapters::Http \
          #{api_version[:schema_path]} \
          http://#{app_name.downcase}/api/#{version_name.downcase} > \
          #{output_path}/lib/#{gem_name_snake}/#{version_name.downcase}/adapters/http.rb"
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
