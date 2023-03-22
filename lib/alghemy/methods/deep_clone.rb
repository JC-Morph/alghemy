module Alghemy
  module Methods
    # Public: Allows iterative cloning of objects.
    module DeepClone
      # Public: Returns unique duplicate of object.
      def deep_clone( obj )
        Marshal.load(Marshal.dump(obj))
      end
    end
  end
end
