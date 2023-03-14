require 'alghemy/meta'
require 'alghemy/cdps'

module Alghemy
  module Meta
    # Public: Define CDP related transforms as methods. Used to make calling
    # these transforms on Matter a much simpler affair.
    module DefineCdps
      extend Meta[:define_transforms]
      define_transforms Cdps
    end
  end
end
