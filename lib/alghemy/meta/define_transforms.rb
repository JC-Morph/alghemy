require 'alghemy/comrades'

module Alghemy
  module Meta
    # Public: Enables Transmutations for an object. Defines individual
    # transformations on object as named methods.
    module DefineTransforms
      private

      # Internal: Method for defining Transforms on Matter. Writes files.
      #
      # Returns new Matter, dependent on Transform.
      def define_transforms( bandoleer )
        bandoleer.equipped.each do |transform|
          define_transform transform
        end
      end

      def define_transform( transform )
        define_method transform do |*priorities, **stuff|
          tran = bandoleer[__callee__]
          expected = tran.expects
          lmnt = self
          lmnt = mould(expected, lmnt) until expected.include? lmnt.affinity
          tran = tran.new(lmnt, *priorities, **stuff)
          Comrades[:alghemist].transmute(lmnt, tran)
        end
      end
    end
  end
end
