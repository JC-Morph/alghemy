require 'alghemy/ancestors'
require 'alghemy/mutagens'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with LADSPA effect plugins.
    class Lad < Ancestors[:transmutation]
      def rubric
        Rubrics[:sock]
      end

      def ladspa
        Mutagens[:ladspa]
      end

      def tran_init
        cata[:plug] = ladspa.assert cata[:plug]
      end

      def write_rubric
        plug = prepare cata[:plug]
        rubric = write.input
        rubric.type(:raw) unless rubric.recognise?(cata[:ext])
        rubric.output.add plug
      end

      def prepare( plug )
        params   = plug.params || {}
        prepared = params.map do |param, info|
          param = param.downcase.gsub(/[\s\/]/, '_').to_sym
          cata[param] || info[:default] || rand_param(info)
        end
        ['ladspa', plug.sijil, prepared].flatten
      end

      private

      def defaults
        {ext: 'wav', plug: ladspa.list.sample}
      end

      def rand_param( info )
        return 0 unless info[:range]
        rand(Range.new(*info[:range]))
      end
    end
  end
end
