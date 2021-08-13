require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more context-specific.
  module Glyphs
    extend Bandoleer

    equip_constants %i[memory memories option pix_fmt scroll sijil]

    invoke = lambda do |ent = nil|
      Ent.invoke ent
    end
    build = lambda do |templates, stuff = {}|
      Options.build templates, stuff
    end
    trace = lambda do |space, subspace = nil|
      Space.trace space, subspace
    end

    equip ent: invoke, options: build, space: trace
  end
end
