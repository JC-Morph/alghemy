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
          **stream_option(:codec,
                          ['libx264', 'aac'],
                          dict: [:ffmpeg_encoders, :_stream],
                          bi: true),
        **stream_option(:quality, [5, 3], dict: (0..100))
        }
      end

      def input
        formats.size.rate if raw?
        pre_codecs.add input: ['-i', '"%{input}"']
      end

      def codecs
        vcodec.acodec
      end

      def pre_codecs
        [:vcodec, :acodec].each do |codec|
          next unless options[codec].value.is_a? Array
          send codec
        end
        self
      end

      def formats
        format.pix_fmt
      end

      def add_ins
        [stuff[:add_in]].flatten.compact.each {|input| add_in input.to_s }
        self
      end

      # Shared transmutations
      def concat
        format.input.codecs.output
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
        vcodec.pix_fmt.output
      end

      private

      # Internal: Generates templates for options that specify a stream.
      # (v - video, a - audio)
      #
      # option   - String of option in command-line format.
      # defaults - Array of default values for each stream.
      def stream_option( option, defaults, dict: nil, **other_vars )
        {Video: :v, Sound: :a}.each_with_object({}) do |(stream, char), hsh|
          label = "#{char}#{option}".to_sym

          hsh[label] = {flag:     "#{option[0]}:#{char}".to_sym,
                        default:  defaults.shift,
                        shortcut: "#{char}#{option[0]}".to_sym,
                        **other_vars}
          hsh[label].merge!(dict: write_dict(dict, stream)) if dict
        end
      end

      def write_dict( dict, stream )
        return dict unless dict.is_a?(Array)
        dict.map {|entry| entry == :_stream ? stream : entry }
      end
    end
  end
end
