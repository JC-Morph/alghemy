require 'alghemy/methods'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied to
  # data. Expected to create new files.
  module Transmutations
    extend Modules[:bandoleer]

    vials = %i[compile
               fft
               frames
               ift
               mutate
               sonify
               sublimate
               visualise]

    equip_constants vials
  end
end
