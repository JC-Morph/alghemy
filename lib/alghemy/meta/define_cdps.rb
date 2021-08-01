require 'alghemy/meta'
require 'alghemy/cdps'

module Alghemy
  module Meta
    module DefineCdps
      extend Meta[:define_transforms]
      define_transforms Cdps
    end
  end
end
