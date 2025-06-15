require 'alghemy/fruit'

module Alghemy
  module Methods
    module Decipher
      def decipher( value )
        Fruit[:automato].parse(value).value
      end
    end
  end
end
