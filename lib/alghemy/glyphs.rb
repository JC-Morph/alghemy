require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more contextual.
  module Glyphs
    extend Bandoleer

    equip %i[memory memory_palace option options scroll sijil size skeleton]

    remember = lambda do |sijil|
      Memories.new Glyphs[:memory_palace].follow_memory(sijil)
    end

    equip_custom memories: remember
  end
end
