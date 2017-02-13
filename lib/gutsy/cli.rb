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
      unless args.length == 2
        puts <<-TEXT
Error: Not enough arguments for command 'generate'

Usage: gutsy generate [config path] [output_path]

DESCRIPTION
    Generates a gem scaffold and resource API clients on top of a heroics-generated client.

ARGUMENTS
    [config path] - Path to gutsy configuration file
    [output_path] - Path to output generated API client gem(s).
                    (Will be created if it doesn't exist)
TEXT
        exit 1
      end

      config_path = File.expand_path(args[0])
      output_path = File.expand_path(args[1])

      config = Gutsy::Configuration.load_from_file!(config_path)

      config.apps.each do |app_config|
        generator = Gutsy::Cli::Generator.new(app_config, output_path)
        begin
          generator.generate!
        rescue => e
          puts "FAIL"
          puts e.message
          puts e.backtrace.join("\n")
          exit 1
        end
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
