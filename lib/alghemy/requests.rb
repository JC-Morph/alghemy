require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain modules that send external commands, but
  # do not create new files.
  module Requests
    extend Modules[:bandoleer]

    equip_constants %i[display eye flay probe scry slay view]
  end
end
