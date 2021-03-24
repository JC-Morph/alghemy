require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied
  # to data. Expected to create new files.
  module Transmutations
    extend Bandoleer

    vials = %i[amorph
               compile
               fft
               frames
               ift
               lad
               mutate
               sonify
               sublimate
               visualise]

    equip_constants vials
  end
end
