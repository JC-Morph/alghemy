require 'alghemy/glyphs'
require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Analyse image files with identify.
    module Scry
      class << self
        include Modules[:analyse]

        def moniker
          ['identify']
        end

        def sub_process
          ['-format'] << cat
        end

        private

        def catdex
          # size, bitdepth, colorspace
          aspdex ['%%P', '%%z', '%%r']
        end

        def fmtdex
          fmts = [->(asp) { Glyphs['space'].call asp },
                  ->(asp) { asp.to_i },
                  ->(asp) { asp.split[1] }]
          aspdex fmts
        end

        def aspdex( arr )
          Scrydex.new(*arr)
        end
        Scrydex = Struct.new(:space, :depth, :arcana)
      end
    end
  end
end
