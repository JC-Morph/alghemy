require_relative 'transmutation'

module Alghemy
  # Public: Split data into multiple files.
  class Split < Transmutation
    def tran_init
      @solution = Elements
    end
  end
end
