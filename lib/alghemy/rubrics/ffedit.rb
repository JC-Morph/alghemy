require 'alghemy/scripts'
require 'alghemy/rubrics'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to the ffedit command, supplied by
    # ffglitch.org. ffedit is an altered ffmpeg binary focussed on glitch-based
    # processing of input.
    class Ffedit < Rubrics[:ffmpeg]
      def self.moniker
        'ffedit -loglevel warning'
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
