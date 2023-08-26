require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more context-specific.
  module Glyphs
    extend Bandoleer

    equip %i[archive memory option options scroll sijil]

    remember = lambda do |sijil|
      Memories.new Glyphs[:archive].retrieve(sijil)
    end

    equip_custom memories: remember
  end
end
