require 'csv'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/scripts'

module Alghemy
  module Ancestors
    class VampClan
      extend Forwardable
      include Methods[:write_to_file]
      delegate data: :format
      delegate size: :list
      attr_reader :sijil

      def initialize( csv )
        @sijil = csv
      end

      def plot( values = data )
        values  = expand values
        coords  = write_coordinates values
        process = [Scripts[:plot_ample], coords, title, alget(:ROOT)]
        Comrades[:invoker].cast process
        File.delete coords
      end

      def normalise( values = data )
        min, max = bounds(values)
        values.map {|n| (n - min).fdiv(max - min) }
      end

      def logalise( values = data )
        min, max = bounds(values)
        min      = min.abs
        values.map do |n|
          n = Math::log((n + min), (max + min))
          n.finite? ? n : 0.0
        end
      end

      def exponise( base = 4, values = data )
        values = values.map {|n| (10 ** base) ** (1.0 / n.abs) }
        normalise values
      end

      private

      def list
        CSV.read sijil
      end

      def expand( values )
        values.is_a?(Symbol) ? send(values) : values
      end

      def title
        "'#{File.basename(sijil, '.*').gsub('_', ' ')}'"
      end

      def format
        raise NotImplementedError
      end

      def write_coordinates( data )
        times  = format[:index].take(size)
        coords = [times, data].transpose.map {|arr| arr * ' ' }
        write_coordinates_to_file coords
      end

      def write_coordinates_to_file( coordinates )
        write_to_file(coordinates, 'vamp_coordinates.dat')
      end

      def bounds( values )
        values = values.sort
        [values.first, values.last]
      end
    end
  end
end
