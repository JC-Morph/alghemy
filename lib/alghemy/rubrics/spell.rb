require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ImageMagick.
    class Spell < Ancestors[:rubric]
      def self.moniker
        ['convert']
      end

      def self.option_templates
        {
          # no argument
          append: {shortcut: :a, preswitch: [:vertical, :horizontal]},
          # no default
          size:  {shortcut: :s},
          depth: {shortcut: :d}
        }
      end

      def sublimate
        size.depth if cata[:raw]
        input.output
      end

      def concat
        input.append.output
      end
    end
  end
end
