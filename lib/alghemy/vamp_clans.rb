require 'bandoleer'

# Public: Bandoleer. Vials contain classes to parse data from vamp plugins used
# by sonic-annotator.
module Alghemy
  module VampClans
    extend Bandoleer

    equip %i[ample spectral]
  end
end
