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
        tran     = Transmutations[__callee__]
        expected = tran.expects
        lmnt = self
        until expected.include?(lmnt.affinity)
          lmnt = mould(lmnt, expected)
        end
        tran = tran.new(lmnt, *focus, **stuff)
        Apparatus[:alghemist].transmute(lmnt, tran)
      end
      # Public: All Transmutations listed become named methods.
      Transmutations.equipped.each do |vial|
        alias_method vial, :transmute
      end

      def mould( lmnt, expected )
        return lmnt.send(*[lmnt.class.mould[expected.first]].flatten)
      end

      def affinity
        raise NotImplementedError
      end
    end
  end
end
