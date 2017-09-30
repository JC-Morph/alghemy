# Allows iterative cloning of objects
module Deepclone
  # Return unique duplicate of object
  def deepclone( obj )
    Marshal.load(Marshal.dump(obj))
  end
end
