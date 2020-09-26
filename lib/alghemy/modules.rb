require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules used to extend other objects.
  module Modules
    extend Bandoleer

    vials = %i[affinitester
               analyse
               aspects
               aspect_finder
               laws
               osman
               plural
               request
               serial_recall
               switcher
               trail]

    equip_constants vials
  end
end
