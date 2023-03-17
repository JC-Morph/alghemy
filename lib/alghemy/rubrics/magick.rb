require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an executable process for imagemagick.
    class Magick < Ancestors[:rubric]
      def self.moniker
        'convert'
      end

      def option_templates
        {
          # no argument
          append_h: {flag: :append, shortcut: :ah, prefix: '+'},
          append_v: {flag: :append, shortcut: :av},
          # no default
          colors:    {},
          depth:     {shortcut: :d},
          posterize: {shortcut: :post},
          size:      {shortcut: :s},
          # with default
          delay:  {default: 3},
          dither: {default: 'floydsteinberg'},
          fuzz:   {default: '22%'}
        }
      end

      # Unique options
      def fuzz( val = nil )
        fuzz  = options[:fuzz]
        val ||= fuzz.increment_value
        val   = val.to_s[/^\d+/] + '%%'
        opt_hist << :fuzz
        add fuzz.print(val)
      end

      # Shared transmutations
      def concat
        opt = %i[v vert vertical].any? {|key| stuff[key] } ?
          'append_v' : 'append_h'
        input.send(opt).output
      end

      def sublimate
        size.depth if is_raw?
        input.output
      end
    end
  end
end
