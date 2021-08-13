require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ImageMagick.
    class Magick < Ancestors[:rubric]
      def self.moniker
        'convert'
      end

      def self.option_templates
        {
          # no argument
          append: {shortcut: :a, preswitch: [:vertical, :horizontal]},
          # no default
          size:  {shortcut: :s},
          depth: {shortcut: :d},
          # with default
          fuzz: {default: '22%'}
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
        input.append.output
      end

      def sublimate
        size.depth if stuff[:is_raw]
        input.output
      end
    end
  end
end
