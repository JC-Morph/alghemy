require 'forwardable'
require 'paint'
require 'alghemy/assistants'
require 'alghemy/factories'
require 'alghemy/methods'

module Alghemy
  module Ancestors
    # Public: A Tome is a collections of Filenames.
    # It is used to make iterating over files easier and more intuitive.
    class Tome
      extend Forwardable
      include Assistants[:gnumbers]
      include Methods[:alget]
      include Methods[:store]
      methods = %i[
        []
        empty?
        first
        last
        size
        each
        inject
        join
        map
        transpose
      ]
      def_delegators :entries, *methods
      attr_reader :entries
      alias_method :all_entries, :entries
      alias_method :each_lmnt,   :each

      def pretty_print( pp )
        index
        pp.pp size
      end

      # Public: Prints each Sijil in Tome to the console.
      def index
        entries.each_with_index do |entry, idx|
          entry = Paint[entry, '#68d66a']
          puts "%-7d#{entry}" % idx
        end
        puts "\n"
      end

      def initialize( files )
        @entries = [files].flatten(1)
      end

      # Public: Multiply #entries to get a recurring Tome.
      #
      # Returns Tome.
      def *( other )
        self.class.new entries * other
      end

      def to_s
        sijil.to_s
      end

      # Public: Compose a Sijil that represents all of Tome.
      # If there are multiple files in Tome, this will include a glob pattern.
      def sijil
        sijil = size < 2 ? first : glob_replace
      end

      # Public: Evoke new Matter from a Tome.
      #
      # memory - Memories object referencing previous states, used for reversion
      #          of Transmutations.
      # record - Boolean whether to store the given memory in the local Archive.
      #
      # Returns Matter.
      def evoke( memory = nil, record = true )
        store(memory) if memory && record
        Factories[:evoker].call(self.class, all_entries)
      end

      # Public: Deletes the files in Tome.
      # Used to clean up after Transmutations, automatic use toggled with
      # Alghemy#leave_no_trace.
      def erase
        dir = sijil.dir
        id  = /#{alget(:ROOT)}#{alget(:SEP)}/
        return unless dir[id]
        each_lmnt {|lmnt| File.delete lmnt.to_s }
        FileUtils.remove_dir(dir) if Dir.children(dir).empty?
      end

      # Public: Ensure collected Tome returns Tome.
      def collect( &block )
        self.class.new entries.collect(&block)
      end

      # Public: Enumerator that treats each enclosed group of Elements as a
      # separate input.
      def each_group_sijil( &block )
        g_sijils = group_sijils
        block_given? ? g_sijils.each_lmnt(&block) : g_sijils.to_enum
      end

      def group_sijils
        Factories[:scribe].call each_group.map(&:glob_replace)
      end

      # Public: Return depth of 2-dimensional lists, i.e a list of lists.
      # This is useful with fourier transforms, when you have two components
      # representing a single file.
      def dims
        dims = e_nums(numbers).compact.size
        dims > 1 ? dims : nil
      end

      # Public: Return Array of all numbers in the first half of Tome's Sijils.
      def numbers
        list = all_entries[0..-(size / 2)].flatten
        num_list list
      end
    end
  end
end
