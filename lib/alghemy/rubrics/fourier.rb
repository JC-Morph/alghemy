require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to fftw-compiled ImageMagick.
    class Fourier < Ancestors[:rubric]
      def self.moniker
        Gem.win_platform? ? 'ffconvert' : 'convert'
      end

      def option_templates
        {
          fft_i: {flag: 'fft'},
          fft_r: {flag: 'fft', prefix: '+'},
          ift_i: {flag: 'ift'},
          ift_r: {flag: 'ift', prefix: '+'}
        }
      end

      # Shared transmutations
      def ffot
        opt = __callee__.to_s.gsub(/a|o/, '')
        opt += stuff[:real] ? '_r' : '_i'
        input.send(opt).output
      end
      alias ifot ffot
    end
  end
end
