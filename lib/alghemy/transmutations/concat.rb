require 'alghemy/affinities'
require 'alghemy/ancestors'

module Alghemy
  # Public: Concatenate Elements.
  class Concat < Ancestors[:transmutation]
    def tran_init
      cata[:enum] = :group
      @solution   = Affinities[:element] unless lmnt.dims
    end
  end
end
