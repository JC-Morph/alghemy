module Alghemy
  module Modules
    # Public: Extension module. Allows the definition of named methods on
    # class. Names are defined as methods on class that pass the name to
    # #find and return the result.
    module AspectFinder
      # Public: Add aspect names as methods.
      def def_asps
        return if aspects.all? {|aspect| method_defined? aspect }
        aspects.each do |aspect|
          define_method aspect do
            find aspect
          end
        end
      end

      # Public: Array of names to be passed to #find, and defined as methods.
      def aspects
        []
      end

      # Public: Empty method to define the retrieval of aspects.
      def find( _aspect )
        raise NotImplementedError
      end
    end
  end
end
