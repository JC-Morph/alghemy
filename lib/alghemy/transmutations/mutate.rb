require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with VST effect plugins.
    class Mutate < Ancestors[:transmutation]
      def self.priorities
        [:plugin, :ext]
      end

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:mrs]
      end

      def vst
        Mutagens[:vst]
      end

      def tran_init
        stuff[:plugin] = vst.new stuff[:plugin]
      end

      def write_rubric( rubric = nil )
        vst = stuff[:plugin].sijil
        rubric = write(rubric).input.plugin(vst)
        rubric.automate if stuff[:data]
        rubric.output
      end

      private

      def defaults
        {
          autotrim: true,
          label:    'V',
          ext:      lmnt.sijil.ext,
          plugin:   vst.list.sample
        }
      end
    end
  end
end
