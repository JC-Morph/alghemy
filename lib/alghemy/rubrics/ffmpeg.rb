require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an Array for a command passed to ffmpeg.
    class Ffmpeg < Ancestors[:rubric]
      extend Methods[:alget]

      def self.moniker
        moniker = %w[ffmpeg -loglevel warning -stats]
        moniker << '-y' if alget(:overwrite)
        moniker.join(' ')
      end

      def option_templates
        {
          # no argument
          no_audio: {flag: :an},
          no_video: {flag: :vn},
          # no default
          pix_fmt: {shortcut: :pf},
          size:    {flag: 'video_size'},
          # with default
          crf:    {default: 12},
          rate:   {flag: 'framerate', default: 30},
          format: {flag: 'f', default: 'rawvideo'},
          # options for audio and video streams
          **stream_option(:codec,   'c', ['libx264', 'aac']),
          **stream_option(:quality, 'q', [5,         3])
        }
      end

      def input
        formats.size.rate if stuff[:is_raw]
        add ['-i', '%<input>s']
      end

      def formats
        format.pix_fmt
      end

      # Shared transmutations
      def compile
        format.rate unless stuff[:is_raw]
        input.output
      end

      def rip
        input
        stuff[:exclude][/^v/i] ? no_video : no_audio
        output
      end

      def sublimate
        input
        stuff[:is_raw] ? vcodec : format
        output
      end
    end

    private

    # Private: Generates switch templates for options that specify a stream.
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
  end
end
