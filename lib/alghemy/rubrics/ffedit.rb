require 'alghemy/rubrics'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to the ffedit command, supplied by
    # ffglitch.org. ffedit is an altered ffmpeg binary focussed on glitch-based
    # processing of input.
    class Ffedit < Rubrics[:ffmpeg]
      def self.moniker
        ['ffedit']
      end

      # alias_method :_option_templates, :option_templates
      def self.option_templates
        super.merge {
          func:   {flag: :f, default: :mv},
          script: {flag: :s, default: 'mv_average.js'}
        }
      end

      def script( name = nil )
        script = send(name) if name
        ['-s', script || options[__callee__].default
      end

      def average
        "mv_#{__callee__}.js"
      end
      alias sink average
    end
  end
end
