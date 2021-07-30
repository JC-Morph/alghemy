require 'alghemy/ancestors'
require 'alghemy/glyphs'

module Alghemy
  module Tomes
    # Public: An indexed collection of Sijils.
    class Grimoire < Ancestors[:tome]
      alias each_lmnt  each
      alias first_lmnt first
      alias last_lmnt  last

      # Public: Constructor. Coerces elements to Sijils. Preferred initialiser.
      def self.scribe( list, _dims = nil )
        new(list).liberate
      end

      # Public: Converts all elements to Sijils.
      def liberate
        collect {|sij| Glyphs[:sijil].new sij }
      end

      # Public: Enumerator method for all elements.
      def each_group
        block_given? ? yield(self) : [self].to_enum
      end

      # Public: Repeat current contents in order to reach a specified number of
      # elements.
      #
      # Returns new Grimoire.
      def repeat( target = size )
        return self unless target > size
        factor = (target.fdiv(size)).ceil
        self.class.scribe((self * factor)[0..target - 1])
      end

      # Public: Distill an appropriate output Sijil from Grimoire.
      def swap_parts( stuff = {} )
        # define abstracted Sijil and swap parts with stuff.
        sijil = globvert.swap_parts stuff
        # remove any identifiable glob patterns.
        sijil.unglob
      end
    end
  end
end
