require 'alghemy/apparatus'
require 'alghemy/transmutations'

module Alghemy
  module Methods
    # Public: Enables Transmutations for an object. Defines individual
    # transformations on object as named methods.
    module Transmute
      # Internal: Transmute method, for calling Transmutations on Matter.
      # Writes files.
      #
      # stuff - Transmutation specific options (default: {}).
      #
      # Returns new Matter, dependent on Transmutation.
      def transmute( *focus, **stuff )
        tran = Transmutations[__callee__].new(self, *focus, **stuff)
        Apparatus[:alghemist].transmute(self, tran, stuff)
      end
      # Public: All Transmutations listed become named methods.
      Transmutations.equipped.each do |vial|
        alias_method vial, :transmute
      end
    end
  end
end
