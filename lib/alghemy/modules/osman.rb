require 'alghemy/affinities'

module Alghemy
  module Modules
    # Public: Writes Rubrics for transmutations.
    module Osman
      # Public: Method that builds command line to be executed.  Can be ducked
      # by transmutations to allow more control.
      def write_rubric
        write.send stuff[:name]
      end

      def write( moniker = nil )
        stuff = self.stuff.merge(is_raw: lmnt.raw?)
        return rubric.write(stuff) unless moniker
        rubric.new.add(moniker).init(stuff)
      end

      # Public: Returns appropritate Rubric class for current transmutation.
      def rubric
        return lmnt.class.rubric unless stuff[:affinity]
        Affinities[stuff[:affinity]].rubric
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
