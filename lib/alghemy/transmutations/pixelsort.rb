require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Pixelsort Images with czycha/pxlsrt.
    class Pixelsort < Ancestors[:transmutation]
      def self.priorities
        [:mode, :min, :max]
      end

      def self.expects
        with_plural :png
      end

      def rubric
        Rubrics[:pxlsrt]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input.output
        rubric.options.each do |name, opt|
          rubric.send(name) unless opt.value.empty?
        end
        rubric
      end
    end
  end
end
