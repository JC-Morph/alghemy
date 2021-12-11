require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to fftw-compiled ImageMagick.
    class Fourier < Ancestors[:rubric]
      def self.moniker
        'ffconvert'
      end

      def option_templates
        {
          fft: {prefix: [:real]},
          ift: {prefix: [:real]}
        }
      end

      # Shared transmutations
      def fft
        input.add(options[__callee__].print).output
      end
      alias ift fft
    end
  end
end
