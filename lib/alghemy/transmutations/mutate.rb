require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with VST effect plugins.
    class Mutate < Ancestors[:transmutation]
      Vst = Mutagens[:vst]
      attr_reader :params

      def self.priorities
        [:plugin, :ext]
      end

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:mrs]
      end

      def tran_init
        stuff[:plugin] = Vst.new stuff[:plugin]
        @params = stuff[:plugin].params
        stuff[:option_templates] = option_templates
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input.plugin(stuff[:plugin].sijil)
        add_params rubric
        rubric.automate if stuff[:data]
        rubric.output
      end

      private

      def defaults
        {
          autotrim: true,
          label:    'V',
          ext:      lmnt.sijil.ext,
          plugin:   Vst.list.sample
        }
      end

      def option_templates
        params.transform_values.with_index do |val, idx|
          {
            delim:   ',',
            prefix:  '--',
            flag:    "parameter #{idx}",
            default: val
          }
        end
      end

      def add_params( rubric )
        params.keys.each do |param|
          rubric.send(param) if stuff.keys.include?(param)
        end
      end
    end
  end
end
