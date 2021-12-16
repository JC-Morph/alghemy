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
        # list  - Array containing filenames.
        # stuff - Hash of initialisation options (default: {}). Passed directly
        # to Matter.
        #
        # Returns new instance of Matter.
        def matter( list )
          matt = format list
          clss = matt.size > 1 ? :elements : :element
          send(clss, list)
        end
        alias grimoire matter

        def sijil( filename )
          element([filename])
        end

        # Public: Constructor. Identify affinity for a single file & initialise.
        #
        # arguments - See #matter.
        #
        # Returns new Element.
        def element( list )
          list = format(list)
          @test_sijil = compose list
          affinity = affinitest
          affinity = pluralise(affinity) if list.size > 1
          Affinities[affinity].new list
        end
        alias elements  element
        alias metamoire element

        # Public: Constructor. Identical to #element, but for multiple files.
        #
        # Returns new Elements.
        # def elements( list )
        #   list = format(list)
        #   @test_sijil = compose list
        #   Affinities[affinitest.to_s.concat('s')].new(list)
        # end
        # alias metamoire elements

        def image( list )
          list = format(list)
          affinity = __callee__
          affinity = pluralise(affinity) if list.size > 1
          Affinities[affinity].new list
        end
        alias images image
        %i[sound video].each do |aff|
          alias_method aff, :image
          alias_method aff.to_s.concat('s'), :image
        end

        # def images( list )
        #   list = format(list)
        #   Affinities[__callee__].new list
        # end
        # alias sounds images
        # alias videos images

        private

        # Public: Returns a String representing the pluralised version of an
        # affinity.
        def pluralise( affinity )
          aff = affinity.to_s.downcase
          return aff if aff[/s$/]
          aff.concat 's'
        end

        def compose( this )
          Glyphs[:sijil].compose this.flatten.first
        end

        def format( input )
          return Dir.glob(input) if is_glob? input
          return [input]         if is_str?  input
          input
        end

        def is_glob?( input )
          is_str?(input) && input[/\*/]
        end

        def is_str?( input )
          input.is_a?(String)
        end

        def match_error( pattern )
          raise IOError, "Cannot find any files matching: #{pattern}"
        end
      end
    end
  end
end
