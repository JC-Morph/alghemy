require 'alghemy/scripts'
require 'alghemy/rubrics'

module Alghemy
  module Rubrics
    # Define an executable process for the ffedit command, supplied by
    # ffglitch.org. ffedit is an altered ffmpeg binary focussed on glitch-based
    # processing of videos.
    class Ffedit < Rubrics[:ffmpeg]
      def self.moniker
        %w[ffedit -loglevel warning]
      end

      def option_templates
        super.merge(
          func:   {flag: :f, default: :mv},
          script: {flag: :s, default: 'mv_average'}
        )
      end

      def script( name = options[__callee__].default )
        add ['-s', Scripts[name]]
      end
    end
  end
end
