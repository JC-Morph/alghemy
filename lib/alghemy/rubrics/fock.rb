require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ffmpeg.
    class Fock < Ancestors[:rubric]
      class << self
        def moniker
          %w[ffmpeg -loglevel warning -stats]
        end

        def option_templates
          {
            format:  {flag: 'f', default: 'rawvideo'},
            pix_fmt: {shortcut: :pfmt},
            **stream_option(:codec,   :c, %w[libx264 aac]),
            **stream_option(:quality, :q, [5, 3]),
            crf: {default: 12},
            size: {flag: 'video_size'},
            rate: {flag: 'framerate', default: 25}
          }
        end

        # Public: Generates switch templates for options that specify a stream.
        # (v - video, a - audio)
        #
        # label  - String of option in command-line format.
        # values - Array of default values for each stream.
        def stream_option( label, flag, defaults )
          %w[a v].collect.with_object({}) do |stream, hsh|
            flag = [flag, stream].join(':')
            hsh[label] = {flag: flag, default: defaults.pop}
          end
        end

        def flags
          {
            noaudio: {flag: :an, prefix: '-'},
            novideo: {flag: :vn, prefix: '-'}
          }
        end
      end

      def sublimate
        input
        cata[:raw] ? vc : format
        output
      end

      def compile
        format.rate unless cata[:raw]
        input.output
      end

      def rip
        input
        cata[:exclude][/^v/i] ? vn : an
        output
      end

      def input
        formats.size.rate if cata[:raw]
        add ['-i', '%<input>s']
      end

      def formats
        format.pix_fmt
      end
    end
  end
end
