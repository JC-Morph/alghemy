require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain wrappers for processes that apply
  # irreversible transformations to data, such as audio plugins.
  module Mutagens
    extend Bandoleer

    equip_constants %i[ladspa vst]
  end
end
