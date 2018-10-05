module Alghemy
  module Methods
    # Public: Simple method for retrieving constants from Alghemy module.
    module Alget
      # Public: Returns Alghemy constant of name sym if sym is capitalized.
      # Otherwise, passes sym to Alghemy#send.
      #
      # sym - Name of desired constant or method.
      def alget( sym )
        return unless self.class.const_defined? :Alghemy
        return Alghemy.send sym if sym == sym.downcase
        Alghemy.const_get sym
      end
    end
  end
end
