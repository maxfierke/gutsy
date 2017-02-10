require 'active_support'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'
require 'erb'
require 'forwardable'
require 'json_schema'
require 'open-uri'
require 'gutsy/cli'

module Gutsy
  def self.initialize!
    Gutsy::Cli.parse!(ARGV)
  end
end
