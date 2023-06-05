require 'alghemy/ancestors'

module Alghemy
  # Public: Concatenate Elements.
  class Conjoin < Ancestors[:transmutation]
    def tran_init
      stuff[:enum] = :group
      @mult = false unless lmnt.dims
    end
  end
end
