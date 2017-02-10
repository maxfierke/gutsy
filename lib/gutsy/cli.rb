require 'gutsy/generator'
require 'gutsy/version'

module Gutsy
  module Cli
    def self.parse!(args)
      command = args[0]

      case command
      when "generate"
        generate(args[1..-1])
      when "version"
        version
      else
        help
      end
    end

    def self.generate(args)
      unless args.length >= 3
        puts <<-TEXT
Error: Not enough arguments for command 'generate'

Usage: gutsy generate [app_name] [schema_path] [output_path] [version]

DESCRIPTION
    Generates a gem scaffold and resource API clients on top of a heroics-generated client.

ARGUMENTS
    [app_name]    - CamelCased name of your application
    [schema_path] - Path to your JSON Schema file
    [output_path] - Path to output generated API client gem.
                    (Will be created if it doesn't exist)
    [version]     - API version to use in client (Default: v1)
TEXT
        exit 1
      end
      app_name = args[0]
      schema_path = File.expand_path(args[1])
      output_path = File.expand_path(args[2])
      version = args[3] || 'v1'

      generator = Gutsy::Cli::Generator.new(app_name, schema_path, output_path, [version])

      begin
        generator.generate!
      rescue => e
        puts "FAIL"
        puts e.message
        puts e.backtrace.join("\n")
        exit 1
      end

      exit 0
    end

    def self.version
      puts "Gutsy version #{Gutsy::VERSION}"
      exit 0
    end

    def self.help
      puts <<-TEXT
Usage: gutsy [command] [options]

DESCRIPTION
    Generates gem wrappers around heroics-generated API clients
    built with JSON Schema. (Enough layers of generation for ya?)

COMMANDS
    generate      scaffolds out an API client
    version       returns the gutsy version
    help          displays this message

Shouts out Mr. Gutsy. Keep on plugging in the Wasteland.
      TEXT
      exit 0
    end
  end
end
