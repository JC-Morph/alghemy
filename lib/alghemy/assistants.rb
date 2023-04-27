require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules used to assist one specific object.
  module Assistants
    extend Bandoleer

    equip_constants %i[vst_info]
  end
end
