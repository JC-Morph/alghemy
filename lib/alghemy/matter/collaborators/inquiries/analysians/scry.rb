require_relative 'analysian'

# Scries an image file with identify
module Scry
  class << self
    include Analysian

    def moniker
      ['identify']
    end

    def sub_process
      ['-format'] << cat
    end

    private

    def catdex
      aspdex %w[%%P %%z %%r]
      # size, bitdepth, colorspace
    end

    def fmtdex
      fmts = [->(asp) { Space.trace asp },
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
