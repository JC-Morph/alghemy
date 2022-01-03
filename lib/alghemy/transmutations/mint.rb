require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Interpolate motion between frames in a Video, creating new frames.
    # Use the pts option to determine the factor by which the video is slowed,
    # which will dictate the number of new frames that are generated.
    class Mint < Ancestors[:transmutation]
      def self.priorities
        %i[pts]
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def tran_init
        stuff[:fps] ||= lmnt.rate || 30
      end

      def write_rubric
        write.input.add(mint).output
      end

      def mint
        pts = "setpts=#{stuff[:pts]}*PTS"
        options = %i[fps scd me_mode search_param vsbmc].map do |opt|
          "#{opt}=#{stuff[opt]}"
        end.join(':')
        ['-vf', "\"#{pts},minterpolate='#{options}'\""]
      end

      private

      def defaults
        {
          ext: 'mp4',
          label: 'M',
          pts: 20,
          scd: :none,
          me_mode: 'bidir',
          search_param: 32,
          vsbmc: 1
        }
      end
    end
  end
end
