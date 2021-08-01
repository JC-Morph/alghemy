require 'alghemy/meta'
require 'alghemy/transmutations'

module Alghemy
  module Meta
    module DefineTransmutations
      extend Meta[:define_transforms]
      define_transforms Transmutations
    end
  end
end
