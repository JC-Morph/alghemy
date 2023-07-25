require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules used to assist one specific object.
  module Assistants
    extend Bandoleer

    vials = %i[affinitester
               aspects
               boots
               gnumbers
               laws
               osman
               serial_recall
               switcher
               trail
               vst_info]

    equip vials
  end
end

