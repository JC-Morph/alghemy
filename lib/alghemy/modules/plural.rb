require 'forwardable'

module Alghemy
  module Modules
    # Public: Methods for Matter representing multiple files.
    module Plural
      extend Forwardable
      # Public: Returns first file in sijil.
      delegate :first => :sijil
      # Public: Slice shortcut for elements in list.
      delegate :[]    => :list

      # Public: Returns Integer of files represented by sijil.
      def count
        sijil.list.size
      end

      private

      # Internal: Check for grouped files during initialisation.
      def sub_init( stuff )
        dims  = stuff[:dims] || list.dims
        @dims = dims if dims && dims > 1
      end
    end
  end
end
