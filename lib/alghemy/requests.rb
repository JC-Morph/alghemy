require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that send external commands, but
  # do not create new files.
  module Requests
    extend Bandoleer

    vials = %i[display
               eye
               flay
               probe
               scry
               slay
               view]

    equip_constants vials
  end
end
