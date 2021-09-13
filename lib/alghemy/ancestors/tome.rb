require 'alghemy/comrades'
require 'alghemy/factories'
require 'alghemy/rubrics'
require_relative 'tome/gnumbers'

module Alghemy
  module Ancestors
    # Public: A Tome is a collections of Filenames. It is used to make
    # iterating over files easier and more intuitive.
    class Tome < Array
      include Gnumbers
      alias _collect collect

      def to_s
        join(' ')
      end

      def sijil
        sijil = size < 2 ? first : globvert
        sijil.limit size
        sijil
      end

      # Public: Ensure collected Tome returns Tome.
      def collect( &block )
        self.class.new _collect(&block)
      end

      def each_group_sijil( &block )
        group_sijils = each_group.collect(&:globvert)
        group_sijils = Factories[:scribe].call group_sijils
        block_given? ? group_sijils.each_lmnt(&block) : group_sijils.to_enum
      end

      # Public: Abstract a Filename with a wildcard that matches all of Tome
      # when used with Dir#glob.
      def globvert
        glob_replace(first_lmnt, numbers)
      end

      # Public: Return depth of 2-dimensional lists, i.e a list of lists. This
      # is useful with fourier transforms, when you have two components
      # representing a single file.
      def dims
        dims = e_nums(numbers).compact.size
        dims > 1 ? dims : nil
      end

      private

      def numbers
        list = self[0..-(size / 2)].to_a.flatten
        num_list list
      end
    end
  end
end
