module Alghemy
  # Public: Handles identifying iterative numbers in filename Strings.
  module Gnumbers
    def num_list( filenames )
      filenames.each.with_object([]) do |filename, arr|
        arr << num_scan(filename)
      end
    end

    def num_scan( filename )
      File.basename(filename.to_s).scan(/\d+/)
    end

    # Public: Replace gnums in filename with a suitable glob pattern.
    def glob_replace( filename, numbers )
      ranges = e_ranges(filename, numbers)
      ranges.reverse_each.with_object(filename.to_s) do |rng, str|
        glob = rng.size > 2 ? '*' : ('?' * rng.size)
        str[rng] = glob
      end
    end

    # Public: Returns Array of ranges for locations of gnums in filename.
    def e_ranges( filename, numbers )
      ranges = []
      e_nums(numbers).each.with_index do |enum, i|
        start  = num_index(filename)[i]
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

    # Internal: Returns Array of indices for numbers in filename.
    def num_index( filename )
      arr = []
      dir = File.dirname filename.to_s
      pad = dir == '.' ? 0 : dir.size.succ
      File.basename(filename.to_s).scan(/\d+/) do
        index = Regexp.last_match.offset(0)[0]
        arr << index + pad
      end
      arr
    end
  end
end
