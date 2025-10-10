require 'ostruct'
require 'alghemy/ancestors'

module Alghemy
  module VampClans
    class Ample < Ancestors[:vamp_clan]
      def count( list = data, split = 10 )
        list     = expand list
        min, max = bounds list
        div      = (max - min) / split

        tally     = count_bounds(list, min, max, div, split)
        max_count = tally.transpose[1].max
        bar_len   = measure_bar max_count
        tally.each do |bounds, count|
          bar   = '█' * (bar_len * count)
          count = count.to_s.ljust(max_count.size)
          puts bounds.join(' | ') + ": #{count}#{bar}"
        end
      end

      private

      def count_bounds( list, min, max, div, split )
        tally = []
        split.times.inject(min) do |low_bound, iteration|
          high_bound = min + (div * iteration.succ)
          count = list.count {|i| i > low_bound && i < high_bound }
          count += 1 if low_bound == min || high_bound.round(3) == max

          bounds = print_range(low_bound, high_bound, max.round)
          tally << [bounds, count]
          high_bound
        end
        tally
      end

      def measure_bar( max_count )
        ((term_width * 0.75) / max_count)
      end

      def format( values = list )
        values = list.transpose[1..2].map {|arr| arr.map(&:to_f) }
        OpenStruct.new data: values[1], index: values[0]
      end

      # Internal: Return prettified String for a set of boundaries.
      def print_range( low_bound, high_bound, max )
        [low_bound, high_bound].map do |boundary|
          bound = boundary.round.to_s
          bound.rjust(max.size - bound.size.succ)
        end
      end

      def term_width
        IO.console.winsize.last
      end
    end
  end
end
