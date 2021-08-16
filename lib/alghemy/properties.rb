require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing properties of files.
  module Properties
    extend Bandoleer

    equip_constants :pix_fmt

    invoke = lambda do |ent = nil|
      Ent.invoke ent
    end
    trace = lambda do |space, subspace = nil|
      Space.trace space, subspace
    end

    equip ent: invoke, space: trace
  end
end
