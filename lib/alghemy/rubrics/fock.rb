require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ffmpeg.
    class Fock < Ancestors[:rubric]
      class << self
        def moniker
          %w[ffmpeg -loglevel warning -stats]
        end

        def switch_templates
          [
            ['f', :format, 'rawvideo'],
            ['pix_fmt', :pf],
            *stream_option('c', %w[libx264 aac]),
            *stream_option('q', [5, 3]),
            ['crf', :constant, 12],
            ['video_size', :size],
            ['framerate', :rate, 25]
          ]
        end

        # Public: Generates switch templates for options that specify a stream.
        # (v - video, a - audio)
        #
        # label  - String of option in command-line format.
        # values - Array of default values for each stream.
        def stream_option( label, values )
          %w[v a].collect.with_index do |stream, i|
            flag = [label, stream]
            [flag.join(':'), flag.reverse.join.to_sym, values[i]]
          end
        end

        def flags
          [
            {label: :an, alias: :video, prefix: '-'},
            {label: :vn, alias: :audio, prefix: '-'}
          ]
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
