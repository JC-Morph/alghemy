require 'forwardable'
require 'paint'
require 'alghemy/factories'
require 'alghemy/modules'

module Alghemy
  module Ancestors
    # Public: Base representation of a transmutable file or group of files.
    class Matter
      extend Forwardable
      include Modules[:aspects]
      include Modules[:laws]
      def_delegators :@list, :[], :first, :last, :sijil, :dims, :dissolve
      attr_reader :list

      # Public: Constructor. Attempts to discern what manner of files are in
      # the list, and then initialise the appropriate subclass.
      # This is the preferred initialisation method for Matter.
      #
      # list - Array containing filenames.
      def self.evoke( list )
        Factories[:evoker].call(self, list)
      end

      def pretty_print( pp )
        aff = Paint[affinity.to_s, self.class.colour, :bold, :underline]
        puts "#{aff}:"
        puts Paint[[' ' * affinity.size, print_name].join, '#68d66a']
        vars = instance_variables.each.with_object({}) do |var, hsh|
          next if var == :@list
          hsh[var] = instance_variable_get(var)
        end
        pp.pp vars
      end

      # Internal: Initialise Matter. Publicly, Matter should always be evoked.
      #
      # list - Array containing filenames.
      def initialize( list )
        @list = Factories[:scribe].call list
        self.class.def_asps
      end

      # Public: Calculate and print aspects.
      def identify
        puts "\nClass => #{affinity} \
        \nsijil => #{sijil}\n\n"
        self.class.aspects.each {|asp| send asp }
        hshprint aspects
      end
      alias id identify

      # Public: Returns the number of files represented by sijil.
      def count
        list.size
      end

      # Public: Open Matter with designated executable.
      def open
        self.class.open.this first
      end

      # Public: Open Matter in OS with default application.
      def behold
        first.behold
      end

      # Public: Returns humanised name of Element affinity.
      # (image, sound, video, or element)
      def affinity
        self.class.name.split('::').last.to_sym
      end

      private

      def print_name
        return first if list.size == 1
        "#{list.size} files in #{list.first_lmnt.dir}"
      end

      # TODO: make analyse method with usable param?
      # Internal: Analyse Matter with designated executable.
      def perceive( asp )
        self.class.analyse.this(first, asp)
      end

      def mould( expected, lmnt = self )
        expected = [expected].flatten.first
        lmnt.send(*[lmnt.class.mould[expected]].flatten)
      end
    end
  end
end
