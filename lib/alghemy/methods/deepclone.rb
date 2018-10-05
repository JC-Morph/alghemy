module Alghemy
  module Methods
    # Public: Allows iterative cloning of objects.
    module Deepclone
      # Public: Returns unique duplicate of object.
      def deepclone( obj )
        Marshal.load(Marshal.dump(obj))
      end
    end
  end
end
