module Alghemy
  module Methods
    # Public: Method for merging two Arrays.
    module ArrayMerge
      # Public: Merge two Arrays.
      #
      # base_array - The Array to be iterated over.
      # sub_array  - The Array to be merged.
      # ignore     - Optional object that will be ignored if found in sub_array.
      #
      # Returns Array.
      def array_merge( base_array, sub_array, ignore = 'Ignored Object' )
        base_array.map.with_index do |element, index|
          next element if index >= sub_array.size
          sub_element = sub_array[index]
          sub_element == ignore ? element : sub_element
        end
      end
    end
  end
end
