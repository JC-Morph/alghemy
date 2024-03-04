require 'alghemy/ancestors'
require 'alghemy/assistants'
require 'alghemy/rubrics'

module Alghemy
  # Public: Concatenate Elements.
  class Concat < Ancestors[:transmutation]
    include Assistants[:fflister]

    def tran_init
      return fflist_prep if Rubrics[:ffmpeg]
      stuff[:enum] = :group
      @mult = false unless lmnt.dims
    end
  end
end
