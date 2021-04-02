require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing a specific format of
  # data. Used to make information more context-specific.
  module Glyphs
    extend Bandoleer

    equip_constants %i[memory memories option pix_fmt sijil]

    invoke = lambda do |ent = nil|
      Ent.invoke ent
    end
    build = lambda do |templates, lyst = {}|
      Options.build templates, lyst
    end
    trace = lambda do |space, subspace = nil|
      Space.trace space, subspace
    end

    equip ent: invoke, options: build, space: trace
  end
end
