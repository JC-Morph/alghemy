require 'alghemy/modules'
require 'alghemy/properties'

module Alghemy
  module Requests
    # Public: Analyse video files with ffprobe.
    module VideoInfo
      class << self
        include Modules[:analyse]

        def moniker
          ['ffprobe -hide_banner']
        end

        def sub_process
          [probe[0], stuff, probe[1]]
        end

        def probe
          [%w[-v error -select_streams v:0 -show_entries],
           %w[-of default=noprint_wrappers=1:nokey=1]]
        end

        def stuff
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
          fmts = [->(asp) { Properties[:space].new asp.split },
                  :to_f,
                  ->(asp) { asp[%r{/}] ? asp : asp.to_f },
                  :to_i]
          aspdex fmts
        end

        def infodex
          %i[size len rate span arcana]
        end
      end
    end
  end
end
