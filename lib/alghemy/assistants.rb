require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules used to assist one specific object.
  module Assistants
    extend Bandoleer

    vials = %i[affinitester
               aspects
               boots
               fflister
               gnumbers
               laws
               osman
               serial_recall
               counselor
               trail
               vst_info]

    equip vials
  end
end
