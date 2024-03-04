require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for ffmpeg.
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
          add_in:   {flag: :i},
          arcana:   {flag: :pix_fmt, shortcut: :pf},
          duration: {flag: :t, shortcut: :dur},
          size:     {flag: 'video_size'},
          # with default
          crf:      {default: 12},
          format:   {default: 'rawvideo', flag: 'f'},
          glob:     {default: 'glob', flag: :pattern_type},
          loop:     {default: 1},
          rate:     {default: 30, flag: 'r'},
          # options for audio and video streams
          **stream_option(:codec,   'c', ['libx264', 'aac']),
          **stream_option(:quality, 'q', [5, 3])
        }
      end

      def input
        formats.size.rate if raw?
        add input: ['-i', '"%{input}"']
      end

      def formats
        format.pix_fmt
      end

      def add_ins
        [stuff[:add_in]].flatten.compact.each {|input| add_in input.to_s }
        self
      end

      # Shared transmutations
      def compile
        glob unless stuff[:pad]
        format.rate unless raw?
        input.add_ins.output
      end

      def concat
        format.input.output
      end

      def convert
        input.add_ins.output
      end

      def rip
        input
        stuff[:exclude][/^v/i] ? no_video : no_audio
        output
      end

      def sublimate
        input
        return format.output unless raw?
        vcodec unless stuff[:ext][/gif/]
        output
      end

      private

      # Internal: Generates switch templates for options that specify a stream.
      # (v - video, a - audio)
      #
      # option   - String of option in command-line format.
      # defaults - Array of default values for each stream.
      def stream_option( option, command, defaults )
        %w[a v].collect.with_object({}) do |stream, hsh|
          label = stream + option.to_s
          flag  = [command, stream].join(':')
          hsh[label] = {flag: flag, default: defaults.pop}
        end
      end
    end
  end
end
