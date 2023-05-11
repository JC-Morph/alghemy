require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain representations of lists of files.
  module Meta
    extend Bandoleer

    definable = %w[aspects
                   cdps
                   transforms
                   transmutations]

    vials = definable.each do |vial|
      vial.prepend('define_').to_sym
    end

    equip_constants vials
  end
end
