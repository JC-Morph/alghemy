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
        {ext: 'wav', label: 'D'}
      end

      def option_templates
        {
          mode:      {flag: '', prefix: '', default: 2},
          threshold: {flag: '', prefix: '', default: 0.2, shortcut: :gate},
          depth:     {flag: '', prefix: '', default: 1},
          freq:      {flag: '', prefix: '', default: 555}
        }
      end
    end
  end
end
