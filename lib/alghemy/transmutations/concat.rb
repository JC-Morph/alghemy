require 'alghemy/ancestors'

module Alghemy
  # Public: Concatenate Elements.
  class Concat < Ancestors[:transmutation]
    def tran_init
      stuff[:enum] = :group
      @mult = false unless lmnt.dims
    end
  end
end
