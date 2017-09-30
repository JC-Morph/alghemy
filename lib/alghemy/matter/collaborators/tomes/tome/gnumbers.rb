# Handles identifying iterative numbers in File format Strings
module Gnumbers
  def num_list( strings )
    strings.each.with_object([]) do |string, arr|
      arr << num_scan(string)
    end
  end

  # Replace gnums in String with a suitable glob pattern.
  def glob_replace( sijil, numbers )
    ranges = granges(sijil, numbers)
    sijil  = sijil.dup
    ranges.reverse.each do |range|
      glob = range.size > 2 ? '*' : ('?' * range.size)
      sijil[range] = glob
    end
    sijil
  end

  # Return numbers in num_list that iterate.
  def gnums( num_list )
    sizes = num_list.collect(&:size).sort
    return [] if sizes.first != sizes.last
    num_list.transpose.collect do |row|
      gnum = row.uniq.size.between?( 2, row.size )
      gnum ? row.first : nil
    end
  end

  private

  def num_scan( sijil )
    File.basename(sijil).scan(/\d+/)
  end

  # Return ranges for locations of gnums in String.
  def granges( sijil, numbers )
    ranges = []
    gnums(numbers).each.with_index do |gnum, i|
      n_index = num_index sijil
      if gnum
        start  = n_index[i]
        finish = start + gnum.size
        ranges << (start..finish - 1)
      end
    end
    ranges
  end

  # Return indices of numbers in String.
  def num_index( sijil )
    arr = []
    pad = File.dirname(sijil).size.succ
    File.basename(sijil).scan(/\d+/) do
      index = Regexp.last_match.offset(0)[0]
      arr << index + pad
    end
    arr
  end
end
