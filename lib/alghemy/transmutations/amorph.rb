require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/glyphs'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform a fast fourier transform with image magick.
    class Amorph < Ancestors[:transmutation]
      def rubriclass
        Rubrics[:fock]
      end

      def tran_init
        which = :output
        if lmnt.raw?
          cata[:space] ||= lmnt.inherit(:space)
          cata[:type]  ||= lmnt.inherit(:type)
          which = :input
        end
        cata[:pf] ||= Glyphs[:pix_fmt].random(which)
      end

      def write_rubric
        if lmnt.raw?
          write.input.output
        else
          write.input.format.pf.output
        end
      end

      def anchors
        return [] if lmnt.raw?
        anchors = [:space]
        anchors << :freq if lmnt.is_a?(Affinities[:video])
      end
    end
  end
end
