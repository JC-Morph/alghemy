module Alghemy
  module Methods
    module BitCheck
      def bit_check( enc, val )
        bit_range = depth_limits.find {|type, _| enc[/#{type}/] }.last
        valid = bit_range.include? val.to_i
        return val if valid
        val > bit_range.last ? bit_range.last : bit_range.first
      end

      private

      def depth_limits
        {
          "^a|u-" => 8..8,
          "un|s"  => 8..64,
          "f"     => 32..64
        }
      end
    end
  end
end
