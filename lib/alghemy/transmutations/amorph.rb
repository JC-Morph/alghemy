require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/properties'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Morph Element's affinity; colorspace, pixel format, or encoding.
    # TODO: Generalise or specialise
    class Amorph < Ancestors[:transmutation]
      def self.priorities
        [:pf, :ext]
      end

      def rubriclass
        Rubrics[:ffmpeg]
      end

      def tran_init
        direction = :output
        heirlooms = {}
        if is_raw?
          direction = :input
          heirlooms = lmnt.inherit([:affinity, :size])
        end
        stuff = heirlooms.merge stuff
        stuff[:pf] ||= Properties[:pix_fmt].random(direction)
      end

      def write_rubric
        rubric = write.input
        rubric.format.pf unless is_raw?
        rubric.output
      end

      def anchors
        return [] if is_raw?
        anchors = [:size]
        anchors << :rate if lmnt.is_a?(Affinities[:video])
      end
    end
  end
end
