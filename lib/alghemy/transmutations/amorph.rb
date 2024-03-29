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
        if raw?
          direction = :input
          heirlooms = lmnt.inherit([:affinity, :size])
        end
        stuff = heirlooms.merge stuff
        stuff[:pf] ||= Properties[:pix_fmt].random(direction)
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input
        rubric.format.pf unless raw?
        rubric.output
      end

      def anchors
        return [] if raw?
        anchors = [:size]
        anchors << :rate if lmnt.is_a?(Affinities[:video])
      end
    end
  end
end
