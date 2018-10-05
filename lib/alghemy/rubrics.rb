require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain modules that build commands for external
  # utilities.
  module Rubrics
    extend Modules[:bandoleer]

    equip_constants %i[ffell fock mrs sock spell]
  end
end
