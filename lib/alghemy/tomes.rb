require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain representations of lists of files.
  module Tomes
    extend Bandoleer

    equip_constants %i[grimoire metamoire]
  end
end
