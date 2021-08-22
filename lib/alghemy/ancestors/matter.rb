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
      def self.evoke( sijil )
        Factories[:evoker].call(self, sijil)
      end

      # Public: Hash of methods to send to self when a Transmutation expects an
      # Element of a different affinity.
      def self.mould
        {
          Sound: :sonify,
          Image: :sublimate,
          Video: [:visualise, {ext: 'mp4'}]
        }
      end

      def self.colour
        'forest green'
      end

      def pretty_print( pp )
        aff = Paint[affinity.to_s, self.class.colour, :bold, :underline]
        puts "#{aff}:"
        vars = instance_variables.each.with_object({}) do |var, hsh|
          hsh[var] = instance_variable_get(var)
        end
        pp.pp vars
      end

      # Internal: Initialise a Matter. Publicly, Matter should always be evoked.
      #
      # sijil - String representing a filename or glob pattern.
      def initialize( sijil )
        @sijil = Glyphs[:sijil].compose sijil
        self.class.def_asps
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

      # Public: Open Matter in OS with default application.
      def behold
        sijil.behold
      end

      # Public: Returns humanised name of Element affinity.
      # (image, sound, video, or element)
      def affinity
        self.class.name.split('::').last.to_sym
      end

      private

      # TODO: make analyse method with usable param?
      # Internal: Analyse Matter with designated executable.
      def perceive( asp )
        self.class.analyse.this(sijil.first, asp)
      end

      def mould( lmnt, expected )
        return lmnt.send(*[lmnt.class.mould[expected.first]].flatten)
      end
    end
  end
end
