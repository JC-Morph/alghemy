require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Compile a Video from Images.
    class Compile < Ancestors[:transmutation]
      def self.priorities
        [:rate, :ext]
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def tran_init
        stuff[:enum]   = :group_sijil
        stuff[:rate] ||= lmnt.inherit(:rate, except: :Sound)
        @mult = false unless lmnt.dims
      end

      private

      def defaults
        {ext: 'mp4', format: 'image2'}
      end
    end
  end
end
