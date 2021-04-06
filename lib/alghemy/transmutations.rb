require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied
  # to data. Expected to create new files.
  module Transmutations
    extend Bandoleer

    vials = %i[amorph
               bend
               compile
               fft
               frames
               ift
               lad
               mint
               mutate
               sonify
               sublimate
               trim
               visualise]

    equip_constants vials
  end
end
