require 'alghemy/methods'
require 'alghemy/modules'

module Alghemy
  module Modules
    # Internal: All necessary inclusions for the Matter class.
    module Laws
      # Hash print method.
      include Methods[:hshprint]
      # Transmutation methods.
      include Methods[:transmute]
      # Memory functions.
      include Modules[:serial_recall]
    end
  end
end
