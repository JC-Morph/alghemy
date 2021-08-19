require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that wrap a single method that is
  # useful in multiple places.
  module Methods
    extend Bandoleer

    vials = %i[alget
               array_merge
               deepclone
               hshprint
               store
               transmute]

    equip_constants vials
  end
end
