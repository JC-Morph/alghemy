require 'alghemy/ancestors'
require 'alghemy/factories'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Compile a Video from Images.
    class Compile < Ancestors[:transmutation]
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
        if stuff[:pad]
          @mult = false
          @tome = pad_input
          stuff[:format] = 'concat'
        else
          @mult = false unless lmnt.dims
          stuff[:enum] = :group_sijil
        end
        stuff[:rate] ||= lmnt.inherit(:rate, except: :Sound)
      end

      private

      def pad_input
        ffinput = '.ffinput.txt'
        list    = tome.entries.
          append(*[tome.first] * 2).
          map {|file| "file '#{file}'\n" }
        File.write(ffinput, list.join)
        Factories[:scribe].call [ffinput]
      end

      def defaults
        {ext: 'mp4', format: 'image2'}
      end
    end
  end
end
