require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing properties of files.
  module Properties
    extend Bandoleer

    equip_constants %i[pix_fmt space]
  end
end
