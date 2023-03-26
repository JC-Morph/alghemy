require 'alghemy/ancestors'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/properties'

module Alghemy
  module Rubrics
    # Public: Define an executable process for sox.
    class Sox < Ancestors[:rubric]
      include Methods[:alget]
      include Methods[:array_merge]

      def self.moniker
        # TODO: make dither optional
        'sox -V1 -D'
      end

      def option_templates
        {
          # no argument
          null: {flag: :n},
          # with default
          rate: {flag: :r, default: 48000},
          type: {flag: :t, default: 'raw'},
          enc:   {flag: :e, default: alget(:encoding), shortcut: :enc},
          depth: {flag: :b, default: alget(:bitdepth), shortcut: :bit}
        }
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
          ent = [options[:e].hist.last, (val || depth.increment_value)]
          val = Properties[:ent].call(ent).bitcheck.separate[:bit]
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
        return unless stuff[:ents]
        Properties[:ent].call(stuff[:ents]).separate.each do |ananym, val|
          stuff[ananym] = array_merge(stuff[ananym], val)
        end
      end
    end
  end
end
