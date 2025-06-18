require 'ostruct'
require 'alghemy/ancestors'

module Alghemy
  module VampClans
    class Spectral < Ancestors[:vamp_clan]
      def count
        band1 = ''
        get_totals.each.with_index do |total, i|
          band2  = 'band_%02d' % i
          band2 += ":\t#{total}"
          if i.even?
            band1 = band2
            puts band1.concat("\t|") if i.succ == size
          else
            puts band1 + "\t|\t" + band2
          end
        end
        size
      end

      def top( n = 2 )
        totals = get_totals
        top    = totals.sort[-n..-1]
        top.map do |total|
          index = totals.index total
          data[index].map {|float| (float.to_f * 100).round }
        end
      end

      def plot( values = data )
        num_tics = 7
        xrange   = list.size
        end_time = format.time.max.to_f
        gap      = (end_time - format[:time].min.to_f) / num_tics

        xtics = num_tics.succ.times.map do |iteration|
          tic_val = (end_time - gap * iteration).round(1)
          tic_pos = (xrange - iteration * (xrange.fdiv num_tics)).round
          "\"#{tic_val}\" #{tic_pos}"
        end.reverse.join(',')

        coords  = write_coordinates values
        process = [Scripts[:plot_spectral], coords, title, "'#{xtics}'"]
        Comrades[:invoker].cast process
        File.delete coords
      end

      private

      def format( csv = list )
        csv = csv.transpose
        OpenStruct.new data: csv[2..-1], time: csv[1]
      end

      def get_totals
        data.map {|band| band.map(&:to_i).reduce(:+) }
      end

      def write_coordinates( data )
        coords = data.map {|band| band.join(' ') }.join("\n")
        write_coordinates_to_file coords
      end
    end
  end
end
