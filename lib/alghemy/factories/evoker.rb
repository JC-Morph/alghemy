require 'alghemy/affinities'
require 'alghemy/glyphs'
require 'alghemy/modules'

module Alghemy
  module Factories
    # Public: Factory module. Initialises child of Matter that best represents
    # Sijil. Uses Affinitester to discern whether a Sijil contains sound, video,
    # or image data. If undiscernable, raw data is presumed.
    module Evoker
      class << self
        include Modules[:affinitester]
        # Internal: Returns Sijil, filename for testing.
        attr_reader :test_sijil

        # Public: Constructor. Identify affinity for arbitrary number of files &
        # initialise. Delegates to methods: element, elements.
        #
        # sijil - String representing a filename or glob pattern.
        # stuff  - Hash of initialisation options (default: {}). Passed directly
        # to Matter.
        #
        # Returns new instance of Matter.
        def matter( sijil )
          sijil = compose sijil
          clss  = sijil.plural? ? :elements : :element
          send(clss, sijil)
        end
        # Public: Alias for matter. Used to evoke Sijils.
        alias sijil matter

        # Public: Constructor. Identify affinity for a single file & initialise.
        #
        # arguments - See #matter.
        #
        # Returns new Element.
        def element( sijil )
          @test_sijil = compose sijil
          Affinities[affinitest].new sijil
        end

        # Public: Constructor. Identical to #element, but for multiple files.
        #
        # Returns new Elements.
        def elements( sijil )
          @test_sijil = compose(sijil).first
          Affinities[affinitest.to_s.concat('s')].new(sijil)
        end

        private

        def compose( sijil )
          Glyphs[:sijil].compose sijil
        end
      end
    end
  end
end
