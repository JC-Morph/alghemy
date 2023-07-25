require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that build commands for external
  # utilities.
  module Rubrics
    extend Bandoleer

    vials = %i[arss
               byebyte
               cdp
               ffedit
               ffmpeg
               fourier
               magick
               mrs
               pxlsrt
               sox]

    equip vials
  end
end

