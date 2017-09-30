require_relative 'evoke/affinitester'

# Public: Factory module. Initialises child of Matter that best represents
# Sijil. Uses Affinitester to discern whether a Sijil contains sound, video, or
# image data. If undiscernable, raw data is presumed.
module Evoke
  class << self
    include Affinitester
    # Internal: Returns Sijil, filename for testing.
    attr_reader :test_sijil

    # Public: Constructor. Identify affinity for arbitrary number of files and
    # initialise. Delegates to methods: element, elements.
    #
    # sijil - String representing a filename or glob pattern.
    # lyst  - Hash of initialisation options (default: {}). Passed directly to
    #         Matter.
    #
    # Returns new instance of Matter.
    def matter( sijil, lyst = {} )
      sijil = compose sijil
      clss  = sijil.plural? ? :elements : :element
      send(clss, sijil, lyst)
    end
    # Public: Alias for matter. Dependency for Sijil.
    alias sijil matter

    # Public: Constructor. Identify affinity for a single file and initialise.
    #
    # arguments - See #matter.
    #
    # Returns Element.
    def element( sijil, lyst = {} )
      @test_sijil = compose sijil
      affinity.new(sijil, lyst)
    end

    # Public: Constructor. Identical to #element, but for multiple files.
    #
    # Returns Elements.
    def elements( sijil, lyst = {} )
      @test_sijil = compose(sijil).first
      plurality.new(sijil, lyst)
    end

    private

    def compose( sijil )
      Sijil.compose sijil
    end

    def plurality
      Matter.const_get affinity.to_s.concat('s')
    end
  end
end
