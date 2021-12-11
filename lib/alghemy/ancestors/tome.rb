require 'forwardable'
require 'paint'
require 'alghemy/factories'
require 'alghemy/glyphs'
require 'alghemy/methods'
require_relative 'tome/gnumbers'

module Alghemy
  module Ancestors
    # Public: A Tome is a collections of Filenames. It is used to make
    # iterating over files easier and more intuitive.
    class Tome
      extend Forwardable
      include Gnumbers
      include Methods[:store]
      def_delegators :entries,
        :[], :first, :last,
        :collect, :each, :transpose,
        :join, :size, :empty?
      attr_reader :entries

      def pretty_print( pp )
        index
        pp.pp size
      end

      def index
        entries.each.with_index do |entry, i|
          entry = Paint[entry, '#68d66a']
          puts "%-7d#{entry}" % i
        end
      end

      def initialize( files )
        @entries = [files].flatten(1)
      end

      def sijil
        sijil = size < 2 ? first : globvert
        Glyphs[:sijil].compose sijil
      end
      alias to_s sijil

      def evoke( memory = nil, record = true )
        store(memory) if memory && record
        Factories[:evoker].call(self.class, entries)
      end

      # Public: Ensure collected Tome returns Tome.
      def collect( &block )
        self.class.new entries.collect(&block)
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

      # Public: Return depth of 2-dimensional lists, i.e a list of lists.
      # This is useful with fourier transforms, when you have two components
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
