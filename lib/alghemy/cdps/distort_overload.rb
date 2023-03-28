require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    # Public: Process Sound with CDP signal clipper.
    class DistortOverload < Ancestors[:transmutation]
      def self.priorities
        [:gate, :depth]
      end

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:cdp]
      end

      def tran_init
        stuff[:option_templates] = {
          mode:      {flag: '', prefix: '', default: 2},
          threshold: {flag: '', prefix: '', default: 0.2, shortcut: :gate},
          depth:     {flag: '', prefix: '', default: 1},
          freq:      {flag: '', prefix: '', default: 555}
        }
      end

      def write_rubric
        rubric = write(moniker).mode.input.output
        rubric.gate.depth
        rubric.freq unless stuff[:mode] == 1
        rubric
      end

      def moniker
        self.class.name.split('::').last.
          split(/(?=[A-Z])/).
          map(&:downcase).
          join(' ')
      end

      private

      def defaults
        {ext: 'wav', label: 'D'}
      end
    end
  end
end
