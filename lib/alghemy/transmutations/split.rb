require 'alghemy/affinities'
require 'alghemy/ancestors'

module Alghemy
  # Public: Split data into multiple files.
  class Split < Ancestors[:transmutation]
    def tran_init
      @solution = Affinities[:elements]
    end
  end
end
