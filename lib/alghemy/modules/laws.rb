require 'alghemy/meta'
require 'alghemy/methods'
require 'alghemy/modules'

module Alghemy
  module Modules
    # Internal: All necessary inclusions for the Matter class.
    module Laws
      # Hash print method.
      include Methods[:hshprint]
      # Memory functions.
      include Modules[:serial_recall]

      # Add transformation methods.
      include Meta[:define_cdps]
      include Meta[:define_transmutations]
    end
  end
end
