require 'alghemy/glyphs'

module Alghemy
  module Requests
    module VampyreBite
      def vampyre_bite( type = 'spec', portions: nil, parameters: {} )
        Glyphs[:vampyre].new(type).bite(self, portions, parameters)
      end
    end
  end
end
