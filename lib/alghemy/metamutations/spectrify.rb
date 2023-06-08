require 'alghemy/factories'

module Alghemy
  module Metamutations
    module Spectrify
      def spectrify( **stuff )
        components = split_rgb(**stuff)
        sounds     = components.dissolve(**stuff)
        mixed      = sounds.conjoin
        return if stuff[:video] == false
        loop_image(mixed.len).convert(add_in: mixed).progress_bar
      end
    end
  end
end
