require 'alghemy/apparatus'
require 'alghemy/methods'
require 'alghemy/modules'

module Alghemy
  module Ancestors
    # Public: Command builder for an executable that processes a file.
    class Rubric
      include Methods[:alget]
      include Modules[:switcher]
      attr_reader :stuff

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
          rubric = new.add moniker
          rubric.init stuff
          rubric
        end

        # Internal: Returns Array containing name of executable and any initial
        # flags.
        def moniker
          [self.class.name.split('::').last.downcase]
        end

        # Public: Array of default templates for options.
        def option_templates
          []
        end
      end

      def init( stuff )
        @stuff = stuff
        sub_init
        build_options stuff
      end

      def scroll
        @scroll ||= []
      end

      def add( passage )
        scroll << passage
        self
      end

      # Public: Executes process with input and output provided. Creates a new
      # file.
      #
      # io - Hash of filenames to use in process:
      #      :input  - String naming input file(s). Files should exist.
      #      :output - String naming output file(s). Files can exist.
      def invoke( io )
        Apparatus[:invoker].io(scroll, io, alget(:print_rubric))
      end

      # Public: Add substitute String for input Filename.
      def input
        add "%{#{__callee__}}"
      end
      # Public: Add substitute for output.
      alias output input

      def convert
        input.output
      end

      private

      # Internal: Duckable initialisation.
      def sub_init
        nil
      end
    end
  end
end
