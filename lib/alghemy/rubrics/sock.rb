require 'alghemy/ancestors'
require 'alghemy/apparatus'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a command passed to Sox.
    class Sock < Ancestors[:rubric]
      include Methods[:array_merge]

      def self.moniker
        # make dither optional
        %w[sox -V1 -D]
      end

      def self.switch_plates
        [
          [:t, :type, 'raw'],
          [:r, :rate, 48_000],
          [:e, :enc,  %w[unsigned float]],
          [:b, :bit,  [8, 32]]
        ]
      end

      def self.flags
        [
          {label: :n, alias: :null, prefix: '-'}
        ]
      end

      def concat
        input.output
      end

      def ents
        enc.bit
      end

      def b( val = nil )
        b = switches.alias :bit
        if hist.last == :enc
          ent = [switches.label(:e).hist.last, val || b.value]
          val = Glyphs[:ent].call(ent).bitcheck.separate[:bit]
        end
        hist << :bit
        add b.print(val)
      end

      def recognise?( ext )
        ext = ext[1..-1] if ext[/^\./]
        raw = Apparatus[:invoker].engage "sox --help-format #{ext}"
        (raw.split("\n")[1] =~ /^Cannot/).nil?
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
