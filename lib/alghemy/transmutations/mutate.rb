require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with VST effect plugins.
    class Mutate < Ancestors[:transmutation]
      def self.priorities
        [:plug, :ext]
      end

      def rubric
        Rubrics[:mrs]
      end

      def plugin
        Mutagens[:vst]
      end

      def tran_init
        stuff[:plug] = plugin.assert stuff[:plug]
      end

      def write_rubric
        plug = stuff[:plug]
        rubric = write.input.plugin(plug.sijil)
        rubric.automate if stuff[:data]
        rubric.output
      end

      private

      def defaults
        {ext: lmnt.sijil.ext, label: 'M', plug: plugin.list.sample}
      end
    end
  end
end
