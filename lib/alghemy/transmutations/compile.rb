require 'alghemy/ancestors'
require 'alghemy/assistants'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Compile a Video from Images.
    class Compile < Ancestors[:transmutation]
      include Assistants[:fflister]

      def self.priorities
        [:rate, :ext]
      end

      def self.expects
        with_plural :Image
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def tran_init
        stuff[:rate] ||= lmnt.inherit(:rate, except: :Sound)
        return fflist_prep(pad: true) if stuff[:pad]
        stuff[:enum] = :group_sijil
        @mult = false unless lmnt.dims
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric)
        rubric.glob unless stuff[:pad]
        rubric.format.rate unless lmnt.raw?
        rubric.input.add_ins.codecs.output
      end

      private

      def defaults
        {ext: 'mp4', format: 'image2'}
      end
    end
  end
end
