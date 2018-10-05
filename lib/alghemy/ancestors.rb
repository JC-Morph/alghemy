require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain abstract superclasses exclusively used by
  # concrete subclasses. These are often not fully implemented, but templates.
  module Ancestors
    extend Modules[:bandoleer]

    equip_constants %i[matter rubric transmutation tome]
  end
end
