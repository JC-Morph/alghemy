require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    # Public: Process Sound with CDP signal clipper.
    class DistortOverload < Ancestors[:cdp_transmutation]
      def self.priorities
        [:gate, :depth]
      end

      def write_rubric
        rubric = write(moniker).mode.input.output
        rubric.gate.depth
        rubric.freq unless stuff[:mode] == 1
        rubric
      end

      private

      def defaults
        super.merge(label: 'D')
      end

      def option_templates
        {
          mode:      {default: 2},
          threshold: {default: 0.2, shortcut: :gate},
          depth:     {default: 1},
          freq:      {default: 555}
        }.transform_values {|val| val.merge(flag: '', prefix: '') }
      end
    end
  end
end
