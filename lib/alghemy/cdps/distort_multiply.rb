require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Cdps
    class DistortMultiply < Ancestors[:transmutation]
      def self.priorities
        [:num]
      end

      def self.expects
        with_plurals :Sound
      end

      def rubric
        Rubrics[:cdp]
      end

      def tran_init
        stuff[:option_templates] = {
          num:    {flag: '', prefix: ''},
          smooth: {flag: :s}
        }
      end

      def write_rubric
        rubric = write(moniker).input.output.num
        rubric.smooth if stuff[:smooth] == true
        rubric
      end

      def moniker
        self.class.name.split('::').last.split(/(?=[A-Z])/).map(&:downcase)
      end

      private

      def defaults
        {ext: 'wav', label: 'D', num: (2..16).to_a.sample}
      end
    end
  end
end