require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain representations of lists of files.
  module Tomes
    extend Modules[:bandoleer]

    equip_constants %i[grimoire metamoire]
  end
end
