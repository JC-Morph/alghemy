require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain representations of lists of files.
  module Meta
    extend Bandoleer

    vials = %w[aspects cdps transforms transmutations].each do |definable|
      definable.prepend('define_').to_sym
    end

    equip_constants vials
  end
end
