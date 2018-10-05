require 'alghemy/tomes'

module Alghemy
  module Factories
    # Public: Return Arrays as appropriate Tomes.
    module Scribe
      class << self
        # Public: Constructor. Returns new Tome.
        #
        # list - Array of Filename formatted Strings, basis for Tome.
        # dims - Integer denoting how many elements to group into each sub-Tome.
        #        Setting this parses list as a 2-dimensional Array (optional).
        def transcribe( list, dims = nil )
          dims ||= tome.scribe(list).dims
          tome(dims).scribe(list, dims)
        end

        # Public: Returns appropriate Tome from dims.
        #
        # dims - See #initialize.
        def tome( dims = nil )
          dims.nil? ? Tomes[:grimoire] : Tomes[:metamoire]
        end
      end
    end
  end
end
