require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain abstract superclasses exclusively used by
  # concrete subclasses. These are often not fully implemented classes, but
  # templates that need to be inherited.
  module Ancestors
    extend Bandoleer

    equip_constants %i[matter rubric transmutation tome]
  end
end
