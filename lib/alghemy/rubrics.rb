require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that build commands for external
  # utilities.
  module Rubrics
    extend Bandoleer

    equip_constants %i[ffmpeg fourier mrs sox magick]
  end
end
