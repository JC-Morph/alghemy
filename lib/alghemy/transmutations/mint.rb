require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with LADSPA effect plugins.
    class Mint < Ancestors[:transmutation]
      def rubric
        Rubrics[:fock]
      end

      def tran_init
        cata[:fps] ||= lmnt.rate || 30
      end

      def write_rubric
        write.input.add(mint).output
      end

      def mint
        pts = "setpts=#{cata[:pts]}*PTS"
        options = %i[fps scd me_mode search_param vsbmc].map do |opt|
          "#{opt}=#{cata[opt]}"
        end.join(':')
        ['-vf', "\"#{pts},minterpolate='#{options}'\""]
      end

      private

      def defaults
        {
          ext: 'mp4',
          label: 'M',
          pts: 20,
          scd: :none,
          me_mode: 'bidir',
          search_param: 32,
          vsbmc: 1
        }
      end
    end
  end
end
