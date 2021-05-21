require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    # Define an Array for a command passed to fftw-compiled ImageMagick.
    class Fourier < Ancestors[:rubric]
      def self.moniker
        ['ffconvert']
      end

      def self.option_templates
        {
          fft: {preswitch: [:imaginary, :real]},
          ift: {preswitch: [:imaginary, :real]}
        }
      end

      # Shared transmutations
      def fft
        [input, send(__callee__), output]
      end
      alias ift fft
    end
  end
end
