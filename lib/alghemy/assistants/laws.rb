require 'alghemy/assistants'
require 'alghemy/meta'
require 'alghemy/methods'

module Alghemy
  module Assistants
    # Internal: All necessary inclusions for the Matter class.
    module Laws
      # Memory functions.
      include Assistants[:serial_recall]
      # Hash print method.
      include Methods[:hshprint]

      # Add transformation methods.
      include Meta[:define_cdps]
      include Meta[:define_transmutations]
    end
  end
end
