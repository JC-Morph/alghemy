require 'alghemy/glyphs'

module Alghemy
  module Requests
    module VampyreBite
      def vampyre_bite( type = 'spect' )
        Glyphs[:vampyre].new(type).bite self.sijil.to_s
      end
    end
  end
end
