require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain subclasses of Matter, representing
  # different types of data. Creates a subclass for each of the specified vials.
  # The subclass represents multiple instances of the affinity. The new constant
  # is defined by appending an 's' to the vial.
  module Affinities
    extend Modules[:bandoleer]

    vials = %i[element image sound video]

    equip_constants vials

    vials.each do |vial|
      plural = Class.new(bandoleer[vial]) do
        include Modules[:plural]
      end
      vial = vial.to_s.concat('s')

      bandoleer.register(vial) do
        const_set(vial.capitalize, plural)
      end
    end
  end
end
