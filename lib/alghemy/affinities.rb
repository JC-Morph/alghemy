require 'alghemy/bandoleer'
require 'alghemy/modules'

module Alghemy
  # Public: Bandoleer. Vials contain subclasses of Matter, representing
  # different types of data. Generates another subclass for each given class,
  # representing multiple instances of the initial one. It is named by appending
  # an 's' to the name of the previous class.
  module Affinities
    extend Bandoleer

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
