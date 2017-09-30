require_relative 'analysian'

# Eyes a sound file with soxi
module Eye
  class << self
    include Analysian

    def moniker
      %w[sox --i]
    end

    def sub_process
      ['-V1'] << cat
    end

    private

    def catdex
      aspdex %w[-D -r -s -b -e]
      # duration, rate, samples, bitdepth, encoding
    end

    def fmtdex
      fmts = [:to_f,
              Array.new(3) { :to_i },
              ->(asp) { asp[0..5].downcase.strip }]
      aspdex fmts.flatten
    end

    def aspdex( arr )
      Eyedex.new(*arr)
    end
    Eyedex = Struct.new(:time, :freq, :lifespan, :depth, :arcana)
  end
end
