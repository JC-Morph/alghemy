require 'bandoleer'

module Alghemy
  # Public. Bandoleer. Vials contain self-contained modules that group related
  # functionality.
  module Comrades
    extend Bandoleer

    equip %i[alghemist cryptographer hunter invoker scout]
  end
end

