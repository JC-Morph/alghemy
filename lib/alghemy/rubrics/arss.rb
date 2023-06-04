require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define a process for the arss resynthesis utility.
    class Arss < Ancestors[:rubric]
      def self.moniker
        'arss -q'
      end

      def option_templates
        {
          min:  {default: 20},
          max:  {default: 20000},
          rate: {default: 48000, flag: :r}
        }.merge prefixed_templates
      end

      private

      def prefixed_templates
        {
          # no argument
          linear:     {shortcut: :l},
          noise:      {shortcut: :n},
          sine:       {shortcut: :s},
          # no default
          bpo:        {shortcut: :b},
          height:     {shortcut: :y},
          width:      {shortcut: :x},
          # with default
          brightness: {shortcut: :g, default: 2},
          pps:        {shortcut: :p, default: 32}
        }.transform_values do |val|
          val.merge prefix: '--'
        end
      end
    end
  end
end
