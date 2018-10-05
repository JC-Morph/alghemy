require 'alghemy/ancestors'
require 'alghemy/rubrics'
require_relative 'mutate/vst'

module Alghemy
  module Transmutations
    # Public: Process Sound with VST effect plugins.
    class Mutate < Ancestors[:transmutation]
      def rubric
        Rubrics[:mrs]
      end

      def tran_init
        cata[:vst] = Vst.assert cata[:vst]
      end

      private

      def defaults
        {ext: lmnt.sijil.ext, label: '(M)', vst: Vst.list.sample}
      end
    end
  end
end
