require 'forwardable'
require 'alghemy/affinities'
require 'alghemy/comrades'

module Alghemy
  module Assistants
    # Public: Writes Rubrics for transmutations.
    module Osman
      extend Forwardable
      delegate raw?: :lmnt
      delegate decipher_options: Comrades[:cryptographer]

      def consolidate_options( stuff )
        deciphered = decipher_options stuff
        amend_tome(deciphered.values.map(&:size).max || 1)
        stuff.merge(deciphered).merge(is_raw: raw?, name: name)
      end

      # Public: Method that builds command line to be executed. Duckable.
      def write_rubric( rubric = nil )
        write(rubric).send stuff[:name]
      end

      # Public: Begin writing a Rubric in the appropriate manner.
      def write( rubric = nil, moniker = nil )
        return rubric.forget if rubric
        rubric = self.rubric
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

      # Public: Expects an instance of Matter provided by class. Must provide
      # #raw? method, to discern whether the input will be raw data.
      def lmnt; end

      def amend_tome( iterations )
        count = lmnt.count
        return unless count < iterations
        @tome = @tome * (iterations / count)
        @mult = true
      end
    end
  end
end
