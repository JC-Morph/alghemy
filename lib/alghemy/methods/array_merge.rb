module Alghemy
  module Methods
    # Public: Method for merging two Arrays.
    module ArrayMerge
      # Public: Merge two Arrays. Uses nil as a reference for substitution.
      #
      # arr    - A value or Array with at least one element. Nil represents an
      #          element to be substituted.
      # subarr - Substitute Array. Should contain desired number of elements.
      #
      # Returns Array.
      def array_merge( arr, subarr )
        arr, subarr = *[arr, subarr].collect {|a| [a].flatten(1).compact }
        drawn = arr.collect.with_index do |dim, i|
          dim.nil? ? subarr[i] : dim
        end
        diff = (subarr.size - drawn.size) > 0
        drawn << subarr[drawn.size..-1] if diff
        drawn.flatten
      end
    end
  end
end
