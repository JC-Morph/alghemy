require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with LADSPA effect plugins.
    class Lad < Ancestors[:transmutation]
      def self.priorities
        [:plug, :ext]
      end

      def rubric
        Rubrics[:sox]
      end

      def plugin
        Mutagens[:ladspa]
      end

      def tran_init
        cata[:plug] = plugin.assert cata[:plug]
      end

      def write_rubric
        plug = prepare cata[:plug]
        rubric = write.input
        rubric.type(:raw) unless rubric.recognise?(cata[:ext])
        rubric.output.add plug
      end

      def prepare( plug )
        params = plug.params || {}
        values = params.map do |param, info|
          param = param.downcase.gsub(/[\s\/]/, '_').to_sym
          cata[param] || info[:default] || rand_param(info)
        end
        ['ladspa', plug.sijil, values].flatten
      end

      private

      def defaults
        {ext: 'wav', label: 'L', plug: plugin.list.sample}
      end

      def rand_param( info )
        return 0 unless info[:range]
        rand(Range.new(*info[:range]))
      end
    end
  end
end
