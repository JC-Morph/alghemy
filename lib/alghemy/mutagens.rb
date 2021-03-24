require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain wrappers for processes that apply
  # irreversible transformations to data, such as audio plugins.
  module Transmutations
    extend Bandoleer

    equip_constants %i[vst]
  end
end
