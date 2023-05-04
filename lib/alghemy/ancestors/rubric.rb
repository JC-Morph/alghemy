require 'alghemy/assistants'
require 'alghemy/comrades'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Ancestors
    # Public: Command builder for an executable that processes a file.
    class Rubric
      include Assistants[:switcher]
      include Methods[:alget]
      attr_reader :scroll, :stuff

      class << self
        # Public: Initialise a Rubric with a String or Array. Any input will be
        # appended to #moniker.
        #
        # transform - String or Array representing initial process.
        def describe( transform )
          write.add transform
        end

        # Public: Initialises a Rubric.
        #
        # stuff - Hash of initialisation options.
        def write( stuff = {} )
          new(moniker, stuff)
        end

        # Internal: Returns Array containing name of executable and any initial
        # flags.
        def moniker
          self.class.name.split('::').last.downcase
        end
      end

      def pretty_print( pp )
        pp.pp scroll
      end

      def initialize( moniker = self.class.moniker, stuff = {} )
        @scroll = Glyphs[:scroll].new(moniker)
        @stuff  = stuff
        sub_init
        build_options(option_templates, stuff)
      end

      # Public: Array of templates for command line options.
      def option_templates
        []
      end

      def add( passage )
        scroll << passage
        self
      end

      def cleanse
        scroll.palimpsest
        self
      end

      # Public: Executes process with input and output provided. Creates a new
      # file.
      #
      # io - Hash of filenames to use in process:
      #      :input  - String naming input file(s). Files should exist.
      #      :output - String naming output file(s). Files can exist.
      def invoke( io )
        spell = scroll.condense(io)
        if alget(:rubric_print)
          shading = alget(:rubric_colour) ? :fancy : :raw
          puts spell[shading].join(' ')
        end
        Comrades[:invoker].cast(spell[:raw])
      end

      # Public: Add substitute String for input Filename.
      def input
        option = __callee__
        add({option => "%{#{option}}"})
      end
      # Public: Add substitute for output.
      alias output input

      def convert
        input.output
      end

      def raw?
        stuff[:is_raw]
      end

      private

      # Internal: Duckable initialisation.
      def sub_init
        nil
      end
    end
  end
end
