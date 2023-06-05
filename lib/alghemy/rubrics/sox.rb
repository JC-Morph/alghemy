require 'alghemy/ancestors'
require 'alghemy/comrades'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for sox.
    class Sox < Ancestors[:rubric]
      include Methods[:alget]
      include Methods[:bit_check]

      def self.moniker
        # TODO: make dither optional
        'sox -V1 -D'
      end

      def option_templates
        {
          # no argument
          null: {flag: :n},
          # with default
          combine: {prefix: '--', default: 'mix'},
          rate: {flag: :r, default: 48000},
          type: {flag: :t, default: 'raw'},
          # bidirectional
          enc:   {bi: true, flag: :e, default: alget(:encoding)},
          depth: {bi: true, flag: :b, default: alget(:bitdepth), shortcut: :bit}
        }.merge(stuff[:option_templates] || {})
      end

      def ents
        enc.bit
      end

      def recognise?( ext )
        ext = ext[1..-1] if ext[/^\./]
        raw = Comrades[:invoker].cast "sox --help-format #{ext}"
        (raw.split("\n")[1] =~ /^Cannot/).nil?
      end

      # Unique options
      def depth( val = nil )
        depth = options[:depth]
        if opt_hist.last == :enc
          enc   = options[:e].hist.last
          val ||= depth.increment_value
          val   = bit_check(enc, val)
        end
        opt_hist << :depth
        add depth.print(val)
      end

      # Shared transmutations
      def conjoin
        input.combine.output.norm
      end

      def concat
        input.output
      end
    end
  end
end
