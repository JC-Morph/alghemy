require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ImageMagick.
    class Spell < Ancestors[:rubric]
      def self.moniker
        ['convert']
      end

      def self.switch_plates
        [
          %i[size space],
          %i[depth bitdepth]
        ]
      end

      def self.flags
        [
          {label: :append, alias: :app, type: 'op', key: :vertical}
        ]
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
