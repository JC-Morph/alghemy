require 'alghemy/transmutations'

module Alghemy
  module Methods
    # Public: Enables Transmutations for an object. Defines individual
    # transformations on object as named methods.
    module Transmute
      # Internal: Transmute method, for calling Transmutations on Matter. Writes
      # files.
      #
      # lyst - Transmutation specific options (default: {}).
      #
      # Returns new Matter, dependent on Transmutation.
      def transmute( lyst = {} )
        Transmutations[__callee__].new(self, lyst).implement
      end
      # Public: Transmutations become named methods.
      Transmutations.equipped.each do |vial|
        alias_method vial, :transmute
      end
    end
  end
end