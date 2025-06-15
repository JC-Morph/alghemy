require 'bandoleer'
require 'citrus'

module Alghemy
  # Public: Bandoleer. Vials contain Citrus definitions for custom parsers.
  module Fruit
    extend Bandoleer

    vials = %w[automato]

    vials.each do |vial|
      pockets.register(vial) do
        dir  = name.split('::').last.downcase
        file = File.join(__dir__, dir, vial)
        Citrus.load file
        Object.const_get vial.capitalize
      end
    end
  end
end
