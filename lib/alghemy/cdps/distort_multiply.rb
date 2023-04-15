require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    # Public: Process Sound with CDP wavecycle frequency multiplier.
    class DistortMultiply < Ancestors[:cdp_transmutation]
      def self.priorities
        [:num]
      end

      def write_rubric
        rubric = write(moniker).input.output.num
        rubric.smooth if stuff[:smooth] == true
        rubric
      end

      private

      def defaults
        super.merge(label: 'D', num: (2..16).to_a.sample)
      end

      def option_templates
        {
          num:    {flag: '', prefix: ''},
          smooth: {flag: :s}
        }
      end
    end
  end
end
