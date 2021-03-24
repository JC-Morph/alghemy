require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with VST effect plugins.
    class Mutate < Ancestors[:transmutation]
      def rubric
        Rubrics[:mrs]
      end

      def plugin
        Mutagens[:vst]
      end

      def tran_init
        cata[:plug] = plugin.assert cata[:plug]
      end

      def write_rubric
        plug = cata[:plug]
        rubric = write.input.plugin(plug.sijil)
        rubric.automate if cata[:data]
        rubric.output
      end

      private

      def defaults
        {ext: lmnt.sijil.ext, label: 'M', plug: plugin.list.sample}
      end
    end
  end
end
