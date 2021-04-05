require 'alghemy/factories'
require 'alghemy/modules'

module Alghemy
  module Ancestors
    # Public: Base class for processes that change Matter in some way, creating
    # one or more new files and returning new Matter.
    class Transmutation
      include Modules[:osman]
      attr_reader :lmnt, :tome, :cata

      # Public: Initialise a Transmutation.
      #
      # lmnt - The Matter to build the transform for.  Expected to represent
      #        part of the input for the transform.
      # lyst - Hash of initialisation options. (default: {})
      def initialize( lmnt, lyst = {} )
        @lmnt     = lmnt
        @tome     = lmnt.list
        @solution = lmnt.class

        @cata = lyst.merge name: name
        sub_init
        prepext
      end

      # Public: Returns a Tome of all files in Array.
      #
      # arr - Array containing Strings of filenames.
      def list( arr )
        Factories[:scribe].call arr
      end

      # Public: Boolean if expected output Class ends with an 's'. Denotes
      # whether output is expected to consist of more than one file.
      def plural?
        !(@solution.to_s =~ /s$/).nil?
      end

      # Public: Array of attribute names used in Transmutation that should be
      # kept in memory so they can be accessed by future Transmutations. This is
      # where we want to put attributes that will be used to revert transforms.
      def anchors
        []
      end

      private

      # Internal: Merges default values with @cata. Serves as duckable
      # initialisation for transforms without default values.
      def sub_init
        @cata = defaults.merge cata
        tran_init
      end

      # Internal: Returns Hash of default values for @cata that can be
      # overridden.
      def defaults
        {ext: lmnt.sijil.ext}
      end

      # Internal: Second-tier duckable initialisation.
      def tran_init
      end

      # Internal: Returns String containing Transmutation class name.
      def name
        self.class.name.split('::').last.downcase
      end

      # Internal: Prepend extension with period if not already present.
      def prepext
        cata[:ext].prepend('.') if cata[:ext][/^[^\.]/]
      end
    end
  end
end
