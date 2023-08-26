require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules used to extend other objects.
  module Modules
    extend Bandoleer

    equip %i[analyse archives request]
  end
end

