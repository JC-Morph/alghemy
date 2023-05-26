require 'forwardable'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/requests'

module Alghemy
  module Assistants
    # Public: Extract information from VST plugins using the mrswatson utility.
    module VstInfo
      extend Forwardable
      include Methods[:alget]
      delegate read_info: Requests[:vst_request]

      def params
        data = find 'Parameters'
        data.each.with_object({}) do |line, hsh|
          key = line[filter[:name]].downcase.to_sym
          val = line[filter[:value]].to_f.round(3)
          hsh[key] = val
        end
      end

      def presets
        data = find 'Programs'
        data.map {|line| line[filter[:name]].to_sym }
      end

      def sijil
        raise NotImplementedError
      end

      private

      def find( target )
        data  = read_info sijil
        match = /#{target}(?= \(.+\):)/
        line = data.index {|line| line[match] }
        size = data[line][filter[:size]]
        data[line.succ..(line + size.to_i)]
      end

      # Internal: Regular expressions used for filtering VST data.
      def filter
        {
          name:  /(?<=').+(?=')/,
          size:  /(?<=\()\d+(?= \w+\):)/,
          value: /(?<=\()-?\d\.\d+(?=\))/
        }
      end
    end
  end
end
