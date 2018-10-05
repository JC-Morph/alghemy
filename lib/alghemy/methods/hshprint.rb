module Alghemy
  module Methods
    # Public: Prints hashes for human eyes.
    module Hshprint
      # Public: Prints a Hash in a more consistent format.
      #
      # hsh - Hash to be printed.
      def hshprint( hsh )
        sizes = hsh.keys.collect(&:size)
        hsh.each do |k, v|
          pad = ' ' * (sizes.max - k.size)
          puts "#{k}#{pad} => #{v}"
        end
      end
    end
  end
end
