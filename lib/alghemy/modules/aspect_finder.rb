module Alghemy
  module Modules
    # Public: Extension module. Allows the definition of named methods on
    # class. Names are defined as methods on class that pass the name to
    # #find and return the result.
    module AspectFinder
      # Public: Meta programming method that adds aspect names as methods. When
      # called they call #aspects on the instance, passing their name.
      def def_asps
        return if aspects.all? {|aspect| method_defined? aspect }
        aspects.each do |aspect|
          define_method aspect do
            aspects aspect
          end
        end
      end

      # Public: Array of names to be passed to #find, and defined as methods.
      def aspects
        []
      end
    end
  end
end
