require 'alghemy/affinities'
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
        cata[:enum] = :group_sijil
        cata[:rate] = lmnt.inherit(:rate, except: :Sound)
        @solution = Affinities[:element] unless lmnt.dims
      end

      private

      def defaults
        {ext: 'mp4', format: 'image2'}
      end
    end
  end
end
