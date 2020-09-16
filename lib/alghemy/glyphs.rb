require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more context-specific.
  module Glyphs
    extend Bandoleer

    equip_constants %i[mems sijil switch]

    invoke = lambda do |ent = nil|
      Ent.invoke ent
    end
    trace = lambda do |space, subspace = nil|
      Space.trace space, subspace
    end
    build = lambda do |plates, lyst = {}|
      Switches.build plates, lyst
    end

    equip ent: invoke, space: trace, switches: build
  end
end
