require 'active_support'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'
require 'erb'
require 'json_schema'
require 'mkmf'
require 'open-uri'
require 'pry'
require 'gutsy/version'
require 'gutsy/cli'

module Gutsy
  def self.initialize!
    args = ARGV

    command = args[0]

    case command
    when "generate"
      app_name = args[1]
      schema_path = File.expand_path(args[2])
      output_path = File.expand_path(args[3])

      generator = Gutsy::Cli::Generator.new(app_name, schema_path, output_path)

      begin
        generator.generate!
      rescue => e
        puts "FAIL"
        puts e.message
        puts e.backtrace.join("\n")
        exit 1
      end

      exit 0
    when "version"
      puts "Gutsy version #{Gutsy::VERSION}"
      exit 0
    else
      puts <<-TEXT
Usage: gutsy [command] [options]

DESCRIPTION
    Generates wrappers around heroics-generated API clients
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
