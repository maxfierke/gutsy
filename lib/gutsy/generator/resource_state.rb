module Gutsy
  module Generator
    class ResourceState
      extend Forwardable

      attr_reader :resource_name, :module_name
      def_delegators :gem_state, :gem_name_pascal, :app_name

      def initialize(resource_name, module_name, gem_state)
        @resource_name = resource_name
        @module_name = module_name
        @gem_state = gem_state
      end

      def twine
        binding
      end

      private

      attr_reader :gem_state
    end
  end
end
