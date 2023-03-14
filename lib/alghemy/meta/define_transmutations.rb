require 'alghemy/meta'
require 'alghemy/transmutations'

module Alghemy
  module Meta
    # Public: Define Transmutations as methods. Used to make calling
    # Transmutations on Matter a much simpler affair.
    module DefineTransmutations
      extend Meta[:define_transforms]
      define_transforms Transmutations
    end
  end
end
