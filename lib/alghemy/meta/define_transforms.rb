require 'alghemy/comrades'

module Alghemy
  module Meta
    # Public: Enables Transmutations for an object. Defines individual
    # transformations on object as named methods.
    module DefineTransforms
      # Internal: Method for defining Transforms on Matter. Writes files.
      #
      # Returns new Matter, dependent on Transform.
      def define_transforms( bandoleer )
        bandoleer.equipped.each do |transform|
          define_method transform do |*focus, **stuff|
            tran     = bandoleer[__callee__]
            expected = tran.expects
            lmnt = self
            until expected.include?(lmnt.affinity)
              lmnt = mould(expected, lmnt)
            end
            tran = tran.new(lmnt, *focus, **stuff)
            Comrades[:alghemist].transmute(lmnt, tran)
          end
        end
      end
    end
  end
end
