require 'alghemy/comrades'
require 'alghemy/methods'

module Alghemy
  module Assistants
    # Public: Extract information from VST plugins using the mrswatson utility.
    module VstInfo
      include Methods[:alget]

      def params
        data = find 'Parameters'
        data.each.with_object({}) do |line, hsh|
          key = line[filter[:name]].to_sym
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
        data = format_info
        hook = /#{target}(?= \(.+\):)/
        line = data.index {|v| v[hook] }
        size = data[line][filter[:size]]
        data[line.succ..(line + size.to_i)]
      end

      def format_info
        write_info
        File.read(tmp_name).split(/\r*\n/)
      end

      def write_info
        FileUtils.makedirs alget(:ROOT)
        spell = "mrswatson.exe -p #{sijil} --display-info 2> #{tmp_name}"
        Comrades[:invoker].cast spell
      end

      # Internal: Regular expressions used for filtering VST data.
      def filter
        {
          name:  /(?<=').+(?=')/,
          size:  /(?<=\()\d+(?= \w+\):)/,
          value: /(?<=\()-?\d\.\d+(?=\))/
        }
      end

      def tmp_name
        File.join(alget(:ROOT), '.vst_info')
      end
    end
  end
end
