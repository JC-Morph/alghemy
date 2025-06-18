require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain abstract superclasses exclusively used by
  # concrete subclasses. These are often not fully implemented classes, but
  # templates that need to be inherited.
  module Ancestors
    extend Bandoleer

    equip %i[cdp_transmutation matter rubric transmutation tome vamp_clan]
  end
end
