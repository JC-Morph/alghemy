require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to fftw-compiled ImageMagick.
    class Fourier < Ancestors[:rubric]
      def self.moniker
        ['ffconvert']
      end

      def self.flags
        {
          fft: {type: 'op', key: :real},
          ift: {type: 'op', key: :real}
        }
      end

      def fft
        [input, send(__callee__), output]
      end
      alias ift fft
    end
  end
end
