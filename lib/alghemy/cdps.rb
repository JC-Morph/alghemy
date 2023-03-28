require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain representations of lists of files.
  module Cdps
    extend Bandoleer

    equip_constants %i[distort_multiply distort_overload rmverb]
  end
end
