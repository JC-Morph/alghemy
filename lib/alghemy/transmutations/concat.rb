require_relative 'transmutation'

module Alghemy
  # Public: Concatenate Elements.
  class Concat < Transmutation
    def tran_init
      cata[:enum] = :group
      @solution   = Element unless lmnt.dims
    end
  end
end
