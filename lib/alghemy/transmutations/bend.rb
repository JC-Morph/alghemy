require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Process Sound with LADSPA effect plugins.
    class Bend < Ancestors[:transmutation]
      def self.priorities
        %i[bends framerate oversample ext]
      end

      def rubric
        Rubrics[:sox]
      end

      def write_rubric
        write.input.output.add bend
      end

      def bend
        options = ["-f #{stuff[:framerate]}", "-o #{stuff[:oversample]}"]
        bends   = parse_bends.map {|bend| bend.join(',') }
        ['bend', options, bends]
      end

      def parse_bends
        bends = stuff[:bends]
        return [[lmnt.len / 2, 1, '-0']] unless bends
        builder = []
        bends.each.with_object([]) do |bend, arr|
          arr << bend && next if bend.is_a?(Array)
          builder << bend
          if builder.size == 3
            arr << builder.dup
            builder.clear
          end
        end
      end

      private

      def defaults
        {ext: 'wav', label: 'B', framerate: 25, oversample: 16}
      end
    end
  end
end
