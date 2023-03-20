require 'alghemy/affinities'

module Alghemy
  module Modules
    # Public: Writes Rubrics for transmutations.
    module Osman
      # Public: Method that builds command line to be executed. Duckable.
      def write_rubric
        write.send stuff[:name]
      end

      # Public: Begin writing a Rubric in the appropriate manner.
      def write( moniker = nil )
        rubric = self.rubric
        stuff  = self.stuff.merge(is_raw: raw?)
        moniker ? rubric.new(moniker, stuff) : rubric.write(stuff)
      end

      # Public: Returns appropritate Rubric class for current transmutation.
      # Duckable.
      def rubric
        rubric = stuff[:rubric]
        return rubric if rubric
        affinity = stuff[:affinity]
        return lmnt.class.rubric unless affinity
        Affinities[affinity].rubric
      end

      # Public: Hash of options to initiaise Rubric with. Duckable.
      def stuff
        {}
      end

      # Public: Boolean whether input is considered raw (uncompressed) data.
      def raw?
        lmnt.raw?
      end

      # Public: Expects an instance of Matter provided by class. Must provide
      # #raw? method, to discern whether the input will be raw data.
      def lmnt
        raise NotImplementedError
      end
    end
  end
end
