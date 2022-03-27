require 'alghemy/affinities'

module Alghemy
  module Modules
    # Public: Writes Rubrics for transmutations.
    module Osman
      # Public: Method that builds command line to be executed. May be ducked by
      # transmutations.
      def write_rubric
        write.send stuff[:name]
      end

      def write( moniker = nil )
        stuff    = self.stuff.merge(is_raw: lmnt.raw?)
        rubric   = self.rubric.write(stuff) unless moniker
        rubric ||= self.rubric.new(moniker, stuff)

      end

      # Public: Returns appropritate Rubric class for current transmutation.
      def rubric
        rubric = stuff[:rubric]
        return rubric if rubric
        affinity = stuff[:affinity]
        return lmnt.class.rubric unless affinity
        Affinities[affinity].rubric
      end

      # Public: Duckable Hash of options to initiaise Rubric with.
      def stuff
        {}
      end

      # Public: Expects an instance of Matter provided by class. Must duck the
      # #raw? method, to discern whether the input will be raw data.
      def lmnt
        raise NotImplementedError
      end
    end
  end
end
