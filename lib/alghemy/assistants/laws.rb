require 'alghemy/assistants'
require 'alghemy/meta'
require 'alghemy/metamutations'
require 'alghemy/methods'

module Alghemy
  module Assistants
    # Internal: All necessary inclusions for the Matter class.
    module Laws
      # Memory functions.
      include Assistants[:serial_recall]
      # Hash print method.
      include Methods[:hshprint]

      # Transformation methods.
      include Meta[:define_cdps]
      include Meta[:define_transmutations]
      # Metamutations.
      Metamutations.equipped.each do |mutation|
        include Metamutations[mutation]
      end
    end
  end
end
