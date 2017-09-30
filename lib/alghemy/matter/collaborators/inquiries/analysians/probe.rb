require_relative 'analysian'

# Probes a video file with ffprobe
module Probe
  class << self
    include Analysian

    def moniker
      ['ffprobe']
    end

    def sub_process
      [probe[0], cata, probe[1]]
    end

    def probe
      [%w[-v error -select_streams v:0 -show_entries],
       %w[-of default=noprint_wrappers=1:nokey=1]]
    end

    def cata
      id = cat != 'duration' ? 'stream' : 'format'
      "#{id}=#{cat}"
    end

    private

    def catdex
      cats = ['height,width',
              'duration',
              'avg_frame_rate',
              'nb_frames',
              'pix_fmt']
      aspdex cats
    end

    def fmtdex
      fmts = [->(asp) { Space.trace asp.split },
              :to_f,
              ->(asp) { asp[%r{/}] ? asp : asp.to_f },
              :to_i]
      aspdex fmts
    end

    def aspdex( arr )
      Probedex.new(*arr)
    end
    Probedex = Struct.new(:space, :time, :freq, :lifespan, :arcana)
  end
end
