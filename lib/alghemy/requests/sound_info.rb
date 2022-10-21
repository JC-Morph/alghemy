require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Analyse sound files with sox.
    module SoundInfo
      class << self
        include Modules[:analyse]

        def moniker
          %w[sox --i]
        end

        def sub_process
          ['-V1'] << cat
        end

        private

        def catdex
          # length, channels, rate, total samples, bitdepth, encoding
          aspdex %w[-D -c -r -s -b -e]
        end

        def fmtdex
          fmts = [:to_f,
                  Array.new(4) { :to_i },
                  ->(asp) { asp[0..4].strip.downcase }]
          aspdex fmts.flatten
        end

        def infodex
          %i[len chans rate span depth arcana]
        end
      end
    end
  end
end
