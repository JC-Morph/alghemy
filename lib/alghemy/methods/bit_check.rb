module Alghemy
  module Methods
    # Public: Method for validating bitdepth values for types of audio encoding.
    module BitCheck
      # Public: Checks whether a given bit value is valid for a given audio
      # encoding type. Possible types are: a-law, u-law, signed, unsigned,
      # and float. If out of range, returns the closest value that isn't.
      #
      # Returns Integer.
      def bit_check( enc, val )
        bit_range = find_bit_range enc
        min, max  = bit_range.minmax
        val = val.to_i
        return val if bit_range.include?(val)
        val < min ? min : max
      end

      private

      def find_bit_range( enc )
        depth_limits.find {|type, _| enc[/#{type}/] }.last
      end

      def depth_limits
        {
          "^a|u" => [8],
          "^s"   => [16, 24, 32],
          "f"    => [32, 48, 64]
        }
      end
    end
  end
end
