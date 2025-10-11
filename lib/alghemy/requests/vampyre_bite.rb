require 'alghemy/glyphs'

module Alghemy
  module Requests
    module VampyreBite
      def vampyre_bite( type = 'spectr', portions: nil )
        Glyphs[:vampyre].new(type).bite(self, portions)
      end
    end
  end
end
