module Gutsy
  class Schema
    def self.load_from_file!(schema_path)
      draft04_uri = URI.parse("http://json-schema.org/draft-04/hyper-schema")
      draft04 = JsonSchema.parse!(JSON.parse(draft04_uri.read))

      schema_json = JSON.parse(File.read(schema_path))

      schema = JsonSchema.parse!(schema_json)
      schema.expand_references!

      draft04.validate!(schema)

      new(schema)
    end

    def initialize(json_schema)
      @schema = json_schema
    end

    def resources
      @resources ||= Hash[schema.definitions.map do |key, resource|
        links = Hash[resource.links.map do |link|
          link.schema.expand_references! if link.schema
          properties = link.schema.try(:properties) || {}
          [link.title.downcase.to_sym, OpenStruct.new(properties: properties)]
        end]
        [key.to_sym, OpenStruct.new(title: key.camelize, links: links)]
      end]
    end

    private

    attr_reader :schema
  end
end