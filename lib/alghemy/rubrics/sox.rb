require 'alghemy/ancestors'
require 'alghemy/apparatus'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a command passed to Sox.
    class Sox < Ancestors[:rubric]
      include Methods[:array_merge]

      def self.moniker
        # TODO: make dither optional
        %w[sox -V1 -D]
      end

      def self.option_templates
        {
          # no argument
          null: {flag: :n},
          # with default
          rate: {flag: :r, default: 48000},
          type: {flag: :t, default: 'raw'},
          depth:  {flag: :b, default: [8, 32], shortcut: :bit},
          encode: {flag: :e, default: %w[unsigned float], shortcut: :enc}
        }
      end

      def ents
        enc.bit
      end

      def recognise?( ext )
        ext = ext[1..-1] if ext[/^\./]
        raw = Apparatus[:invoker].engage "sox --help-format #{ext}"
        (raw.split("\n")[1] =~ /^Cannot/).nil?
      end

      # Unique options
      def depth( val = nil )
        depth = options[:depth]
        if opt_hist.last == :encode
          ent = [options[:e].hist.last, (val || depth.increment_value)]
          val = Glyphs[:ent].call(ent).bitcheck.separate[:bit]
        end
        opt_hist << :depth
        add depth.print(val)
      end

      # Shared transmutations
      def concat
        input.output
      end

      private

      def sub_init
        return unless cata[:ents]
        Glyphs[:ent].call(cata[:ents]).separate.each do |ananym, val|
          cata[ananym] = array_merge(cata[ananym], val)
        end
      end
    end
  end
end
