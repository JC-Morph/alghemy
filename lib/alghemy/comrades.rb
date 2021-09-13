require 'alghemy/bandoleer'

module Alghemy
  # Public. Bandoleer. Vials contain self-contained modules that group related
  # functionality.
  module Comrades
    extend Bandoleer

    equip_constants %i[alghemist hunter invoker scout]
  end
end
