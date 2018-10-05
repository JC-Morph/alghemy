require 'alghemy/modules'

module Alghemy
  # Public. Bandoleer. Vials contain self-contained modules grouping relevant
  # functionality.
  module Apparatus
    extend Modules[:bandoleer]

    equip_constants %i[ears invoker]
  end
end
