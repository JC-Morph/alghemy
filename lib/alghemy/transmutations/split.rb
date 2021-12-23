require 'alghemy/ancestors'

module Alghemy
  # Public: Split data into multiple files.
  class Split < Ancestors[:transmutation]
    def tran_init
      @mult = true
    end
  end
end
