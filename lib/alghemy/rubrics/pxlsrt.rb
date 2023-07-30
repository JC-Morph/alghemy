require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a brute pixelsort.
    class Pxlsrt < Ancestors[:rubric]
      def self.moniker
        %w[pxlsrt brute]
      end

      def option_templates
        {
          # no argument
          vertical: {flag: :v},
          diagonal: {flag: :d},
          smooth:   {flag: :s},
          # no default
          min: {prefix: '--'},
          max: {prefix: '--'},
          reverse: {flag: :r},
          middle:  {flag: :M}
        }
      end
    end
  end
end
