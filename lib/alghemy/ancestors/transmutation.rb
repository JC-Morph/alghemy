require 'alghemy/assistants'

module Alghemy
  module Ancestors
    # Public: Base class for processes that change Matter in some way, creating
    # one or more new files in the process.
    #
    # Returns Matter.
    class Transmutation
      include Assistants[:osman]
      attr_reader :lmnt, :tome, :mult, :stuff

      class << self
        # Public: This method can be used by individual Transmutations to specify
        # the preferential order for options, followed when they are passed prior
        # to keyword arguments.
        # For example, with crop or scale, the priorities are [:size, :ext],
        # as size will always want to be defined for these Transmutations.
        def priorities
          [:ext]
        end

        # Public: Which affinity (image, sound, video, element) the Transmutation
        # is designed for. Elements of other affinities will be coerced as
        # defined by Affinity#mould.
        def expects
          with_plurals %i[Image Sound Video Element]
        end

        def with_plural( affinities )
          [affinities].flatten.map do |aff|
            [aff, [aff, 's'].join.to_sym]
          end.flatten
        end
        alias with_plurals with_plural
      end

      # Public: Initialise a Transmutation.
      #
      # lmnt       - Matter to be transmuted.
      # priorities - Array of values for prioritised options, as determined by
      #              self.class.priorities.
      # stuff      - Hash of initialisation options.
      def initialize( lmnt, *priorities, **stuff )
        @lmnt = lmnt
        @tome = lmnt.list
        @mult = true if lmnt.count > 1

        @stuff = stuff.merge name: name
        gather priorities unless priorities.empty?
        sub_init
        prepext
      end

      # Public: Array of attribute names used in Transmutation that should be
      # kept in memory so they can be accessed by future Transmutations. This is
      # where we want to put attributes that will be used to revert transforms.
      def anchors
        []
      end

      private

      # Internal: Add options specified by class #priorities to rubric.
      #
      # Returns Rubric.
      def add_priorities( rubric )
        self.class.priorities.each do |opt|
          rubric.send(opt) if stuff[opt]
        end
        rubric
      end

      # Internal: Populate @stuff with the ordered arguments provided.
      def gather( priorities )
        priorities.each_with_index do |option, i|
          stuff[self.class.priorities[i]] = option
        end
      end

      # Internal: Merges default values with @stuff. Serves as duckable
      # initialisation for transforms without default values.
      def sub_init
        @stuff = defaults.merge stuff
        tran_init
      end

      # Internal: Returns Hash of default values for @stuff that can be
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
        ext = stuff[:ext].to_s
        return if ext[/^\./]
        stuff[:ext] = ext.prepend('.')
      end
    end
  end
end
