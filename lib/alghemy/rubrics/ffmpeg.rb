require 'alghemy/ancestors'
require 'alghemy/data'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for ffmpeg.
    class Ffmpeg < Ancestors[:rubric]
      extend Methods[:alget]

      class << self
        def encoders
          Data[:ffmpeg_encoders]
        end

        def random_encoder( element = :Video )
          encoders[element].keys.sample
        end

        def moniker
          moniker = %w[ffmpeg -loglevel warning -stats]
          moniker << '-y' if alget(:overwrite)
          moniker.join(' ')
        end
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

      def codecs
        vc = case stuff[:ext]
             when '.gif'
               'gif'
             when '.flv'
               'flv1'
             end
        options[:vcodec].value = vc if vc
        vcodec.acodec
      end

      def encoders
        Data[:ffmpeg_encoders]
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
        input.add_ins.rate.codecs.output
      end

      def rip
        input
        stuff[:exclude][/^v/i] ? no_video : no_audio
        output
      end

      def sublimate
        input
        return format.output unless raw?
        vcodec.output
      end

      def random_encoder
        self.class.encoders.keys.sample
      end

      private

      # Internal: Generates switch templates for options that specify a stream.
      # (v - video, a - audio)
      #
      # option   - String of option in command-line format.
      # defaults - Array of default values for each stream.
      def stream_option( option, command, defaults )
        %w[a v].collect.with_object({}) do |stream, hsh|
          label = (stream + option.to_s).to_sym
          flag  = [command, stream].join(':')
          hsh[label] = {flag: flag, default: defaults.pop}
        end
      end
    end
  end
end
