require 'csv'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/scripts'

module Alghemy
  module Ancestors
    class VampClan
      extend Forwardable
      include Methods[:write_to_file]
      def_delegators :format, :data, :timestamps
      alias d data
      delegate size: :list
      attr_reader :sijil

      def initialize( csv )
        @sijil = csv
      end

      def victim
        "'#{list[0][0].split('/')[1..-1].join('/').gsub('_', ' ')}'"
      end

      def plot( values = data )
        values  = expand values
        coords  = write_coordinates values
        process = [Scripts[:plot_ample], coords, victim, alget(:ROOT)]
        Comrades[:invoker].cast process
        File.delete coords
      end

      def normalise( values = data )
        min, max = bounds(values)
        values.map {|n| (n - min).fdiv(max - min) }
      end
      alias norm normalise
      alias n    norm

      def logalise( values = data )
        min, max = bounds(values)
        min      = min.abs
        values.map do |n|
          n = Math::log((n + min), (max + min))
          n.finite? ? n : 0.0
        end
      end
      alias log logalise
      alias l   log

      def exponise( base = 4, values = data )
        values = values.map {|n| (10 ** base) ** (1.0 / n.abs) }
        normalise values
      end
      alias exp exponise
      alias e   exp

      private

      def list
        CSV.read sijil
      end

      def expand( values )
        values.is_a?(Symbol) ? send(values) : values
      end

      def format
        raise NotImplementedError
      end

      def write_coordinates( data )
        xax    = timestamps.take size
        coords = [xax, data].transpose.map {|arr| arr * ' ' }
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
