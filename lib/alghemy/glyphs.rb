require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more context-specific.
  module Glyphs
    extend Bandoleer

    equip_constants %i[archive memory memories option scroll sijil]

    build = lambda do |templates, stuff = {}|
      Options.build templates, stuff
    end

    equip options: build
  end
end
