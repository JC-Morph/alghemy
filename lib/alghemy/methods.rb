require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that wrap a single method that is
  # useful in multiple places.
  module Methods
    extend Bandoleer

    vials = %i[alget
               array_merge
               bit_check
               decipher
               deep_clone
               hshprint
               store_memory
               transmute]

    equip vials
  end
end
