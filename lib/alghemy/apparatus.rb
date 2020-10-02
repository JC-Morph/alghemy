require 'alghemy/bandoleer'

module Alghemy
  # Public. Bandoleer. Vials contain self-contained modules that group related
  # functionality.
  module Apparatus
    extend Bandoleer

    equip_constants %i[alghemist ears invoker]
  end
end
