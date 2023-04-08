require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain classes representing properties of files.
  module Properties
    extend Bandoleer

    equip_constants :pix_fmt

    trace = lambda do |space, subspace = nil|
      Space.trace space, subspace
    end

    equip space: trace
  end
end
