require 'alghemy/factories'
require 'alghemy/modules'

module Alghemy
  module Ancestors
    # Public: Base class for processes that change Matter in some way, creating
    # one or more new files in the process.
    #
    # Returns Matter.
    class Transmutation
      include Modules[:osman]
      attr_reader :lmnt, :tome, :cata

      # Public: This method can be used by individual Transmutations to specify
      # the preferential order for options, followed when they are passed prior
      # to keyword arguments.
      # For example, with crop or scale, the priorities are [:size, :ext],
      # as size will always want to be defined for these Transmutations.
      def self.priorities
        [:ext]
      end

      # Public: Initialise a Transmutation.
      #
      # lmnt - The Matter to build the transform for. Usually this is the input
      #        file for the transform.
      # dict - Hash of initialisation options. (default: {})
      def initialize( lmnt, *priorities, **dict )
        @lmnt     = lmnt
        @tome     = lmnt.list
        @solution = lmnt.class

        @cata = dict.merge name: name
        gather priorities unless priorities.empty?
        sub_init
        prepext
      end

      # Public: Returns a Tome of all files in Array.
      #
      # arr - Array containing Strings of filenames.
      def list( arr )
        Factories[:scribe].call arr
      end

      # Public: Boolean if expected output Class ends with an 's'. True if
      # output is expected to create more than one file.
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

      # Internal: Populate @cata with the ordered arguments provided.
      def gather( priorities )
        priorities.each.with_index do |option, i|
          cata[self.class.priorities[i]] = option
        end
      end

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
        ext = cata[:ext].to_s
        ext.prepend('.') if ext[/^[^\.]/]
        cata[:ext] = ext
      end
    end
  end
end
