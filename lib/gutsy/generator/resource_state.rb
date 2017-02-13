module Gutsy
  module Generator
    class ResourceState
      extend Forwardable

      attr_reader :resource_name
      def_delegators :version_state, :gem_name_pascal, :app_name, :module_name

      def initialize(resource_name, version_state)
        @resource_name = resource_name
        @version_state = version_state
      end

      def twine
        binding
      end

      private

      attr_reader :version_state
    end
  end
end
