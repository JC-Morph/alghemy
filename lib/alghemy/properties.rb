require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing properties of files.
  module Properties
    extend Bandoleer

    equip %i[pix_fmt size]
  end
end
