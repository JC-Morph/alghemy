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

      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:sox]
      end

      def plugin
        Mutagens[:ladspa]
      end

      def write_rubric( rubric = nil )
        plug   = stuff[:plug]
        rubric = write(rubric).input
        rubric.type(:raw) unless rubric.recognise?(stuff[:ext])
        rubric.output.add ['ladspa', plug.sijil]
        snake_params.each {|param, _info| rubric.send param }
        rubric
      end

      private

      def defaults
        {ext: 'wav', label: 'L', plug: plugin.list.sample}
      end

      def tran_init
        stuff[:plug] = plugin.assert stuff[:plug]
        stuff[:option_templates] = option_templates
      end

      def option_templates
        snake_params.transform_values do |info|
          {
            flag:    '',
            prefix:  '',
            default: info[:default] || rand_param(info)
          }
        end
      end

      def prepare( plug )
        params = plug.params || {}
        values = params.map do |param, info|
          param = param.downcase.gsub(%r{[\s/]}, '_').to_sym
          stuff[param] || info[:default] || rand_param(info)
        end
        ['ladspa', plug.sijil, values].flatten
      end

      def rand_param( info )
        return 0 unless info[:range]
        rand(Range.new(*info[:range]))
      end

      def snake_params
        params = stuff[:plug].params || []
        params.each.with_object({}) do |(param, info), hsh|
          param = param.downcase.gsub(%r{[\s/]}, '_').to_sym
          hsh[param] = info
        end
      end
    end
  end
end
