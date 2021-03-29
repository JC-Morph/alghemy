module Alghemy
  # Public: Handles identifying iterative numbers in Filename Strings.
  module Gnumbers
    def num_list( strings )
      strings.each.with_object([]) do |string, arr|
        arr << num_scan(string)
      end
    end

    def num_scan( string )
      File.basename(string).scan(/\d+/)
    end

    # Public: Replace gnums in String with a suitable glob pattern.
    def glob_replace( string, numbers )
      ranges = e_ranges(string, numbers)
      ranges.reverse_each.with_object(string.dup) do |rng, str|
        glob = rng.size > 2 ? '*' : ('?' * rng.size)
        str[rng] = glob
      end
    end

    # Public: Returns Array of ranges for locations of gnums in String.
    def e_ranges( string, numbers )
      ranges = []
      e_nums(numbers).each.with_index do |enum, i|
        start  = num_index(string)[i]
        finish = start + enum.size - 1
        ranges << (start..finish)
      end
      ranges
    end

    # Public: Returns Array of numbers in num_list that iterate.
    def e_nums( num_list )
      sizes = num_list.collect(&:size).sort
      return [] if sizes.first != sizes.last
      num_list.transpose.collect do |row|
        enum = row.uniq.size.between?( 2, row.size )
        enum ? row.first : nil
      end.compact
    end

    private

    # Internal: Returns Array of indices for numbers in String.
    def num_index( string )
      arr = []
      dir = File.dirname string
      pad = dir == '.' ? 0 : dir.size.succ
      File.basename(string).scan(/\d+/) do
        index = Regexp.last_match.offset(0)[0]
        arr << index + pad
      end
      arr
    end
  end
end
