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

      def rubric
        Rubrics[:mrs]
      end

      def vst
        Mutagens[:vst]
      end

      def tran_init
        stuff[:plugin] = vst.assert stuff[:plugin]
      end

      def write_rubric
        vst = stuff[:plugin].sijil
        rubric = write.input.plugin(vst)
        rubric.automate if stuff[:data]
        rubric.output
      end

      private

      def defaults
        {ext: lmnt.sijil.ext, label: 'M', plugin: vst.list.sample}
      end
    end
  end
end
