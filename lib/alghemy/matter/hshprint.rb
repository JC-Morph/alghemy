# Print hashes for human eyes
module Hshprint
  def hshprint( hsh )
    sizes = hsh.keys.collect(&:size)
    max   = sizes.sort.last
    hsh.each do |k, v|
      pad = ' ' * (max - k.size)
      puts "#{k}#{pad} => #{v}"
    end
  end
end
