require 'active_support'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'
require 'erb'
require 'forwardable'
require 'json_schema'
require 'open-uri'
require 'yaml'

require 'gutsy/configuration'
require 'gutsy/schema'
require 'gutsy/generator'
require 'gutsy/version'
require 'gutsy/cli'

module Gutsy
  def self.initialize!
    Gutsy::Cli.parse!(ARGV)
  end
end
