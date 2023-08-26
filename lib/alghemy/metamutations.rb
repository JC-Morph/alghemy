require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain methods that perform collections of
  # transmutations formations that can be applied to data.
  # Expected to create new files.
  module Metamutations
    extend Bandoleer

    equip %i[paramtest spectrify]
  end
end

