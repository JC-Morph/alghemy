require 'alghemy/apparatus'
require 'alghemy/factories'
require 'alghemy/glyphs'
require 'alghemy/modules'
require 'alghemy/requests'

module Alghemy
  module Ancestors
    # Public: Base representation of a transmutable file or group of files.
    class Matter
      include Modules[:aspects]
      include Modules[:laws]
      attr_reader :sijil, :dims

      # Public: Opens Matter in the OS using a command-line program.
      def self.open
        Requests[:image_open]
      end

      # Public: Constructor. Attempts to discern what sort of file sijil is, and
      # then initialise the appropriate subclass. This is the preferred
      # initialisation method for Matter.
      #
      # sijil - See #initialize.
      # stuff  - See #initialize.
      def self.evoke( sijil, stuff = {} )
        Factories[:evoker].call(self, sijil, stuff)
      end

      # Internal: Initialise a Matter. Publicly, Matter should always be evoked.
      #
      # sijil - String representing a filename or glob pattern.
      # stuff  - Hash of initialisation options (default: {}):
      #         :mems - Memories of previous transforms (optional).
      def initialize( sijil, stuff = {} )
        @sijil = Glyphs[:sijil].compose sijil
        self.class.def_asps
        sub_init stuff
        mem_init stuff[:mems]
      end

      # Public: Returns Tome of all files in sijil.
      def list
        Factories[:scribe].call(sijil.list, dims)
      end

      # Public: Calculate and print aspects.
      def identify
        clss = self.class
        puts "\nClass => #{clss.name.split('::').last} \
        \nsijil => #{sijil}\n\n"
        clss.aspects.each {|asp| send asp }
        hshprint aspects
      end
      alias id identify

      # Public: Open Matter with designated executable.
      def open
        self.class.open.this sijil
      end

      # Public: Open Matter with default application.
      def behold
        sijil.behold
      end

      private

      # Internal: Duckable initialisation, intended for subclasses.
      def sub_init( _stuff )
        nil
      end

      # TODO: make analyse method with usable param?
      # Internal: Analyse Matter with designated executable.
      def perceive( asp )
        self.class.analyse.this(sijil.first, asp)
      end
    end
  end
end
