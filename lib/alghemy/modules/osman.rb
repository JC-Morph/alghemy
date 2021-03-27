require 'alghemy/affinities'

module Alghemy
  module Modules
    # Public: Writes Rubrics for transmutations.
    module Osman
      # Public: Method that builds command line to be executed.  Can be ducked
      # by transmutations to allow more control.
      def write_rubric
        write.send cata[:tran]
      end

      def write
        rubric.write cata.merge(raw: lmnt.raw?)
      end

      # Public: Returns appropritate Rubric class for current transmutation.
      def rubric
        return lmnt.class.rubric unless cata[:affinity]
        Affinities[cata[:affinity].downcase].rubric
      end

      # Public: Duckable Hash of options to initiaise Rubric with.
      def cata
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
