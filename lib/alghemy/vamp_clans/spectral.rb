require 'ostruct'
require 'alghemy/ancestors'

module Alghemy
  module VampClans
    class Spectral < Ancestors[:vamp_clan]
      def top( n = 2 )
        totals = bands
        top    = totals.sort[-n..-1]
        top.map do |total|
          index = totals.index total
          data[index].map {|float| (float.to_f * 100).round }
        end
      end

      def plot( values = data )
        coords  = write_coordinates values
        process = [Scripts[:plot_spectral], coords, victim, "'#{xtics}'"]
        Comrades[:invoker].cast process
        File.delete coords
      end

      def plot_bands
        xax     = (1..bands.size).to_a
        coords  = [xax, bands].transpose.map {|arr| arr * ' ' }
        coords  = write_coordinates_to_file coords
        process = [Scripts[:plot_bands], coords, victim]
        Comrades[:invoker].cast process
        File.delete coords
      end

      def bands
        data.map {|band| band.map(&:to_i).reduce(:+) }
      end

      private

      def format( csv = list )
        csv = csv.transpose.map {|arr| arr.map(&:to_f) }
        values = [csv[2..-1], csv[1]]
        OpenStruct.new data: values[0], timestamps: values[1]
      end

      def write_coordinates( data )
        coords = data.map {|band| band.join(' ') }.join("\n")
        write_coordinates_to_file coords
      end

      def xtics
        num_tics = 6
        xrange   = list.size
        end_time = timestamps.max.to_f
        gap      = (end_time - timestamps.min.to_f) / num_tics

        xtics = num_tics.succ.times.map do |iteration|
          tic_val = (end_time - gap * iteration).round
          tic_pos = (xrange - iteration * (xrange.fdiv num_tics)).round
          "\"#{tic_val}\" #{tic_pos}"
        end.reverse.join(',')
      end
    end
  end
end
