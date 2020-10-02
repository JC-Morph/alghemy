require 'alghemy/apparatus'
require 'alghemy/methods'
require 'alghemy/modules'

module Alghemy
  module Ancestors
    # Public: Command builder for an executable that processes a file.
    class Rubric
      include Methods[:alget]
      include Modules[:switcher]
      attr_reader :cata

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
        # lyst - Hash of initialisation options.
        def write( lyst = {} )
          rubric = new.add moniker
          rubric.init lyst
          rubric
        end

        # Internal: Returns Array containing name of executable and any initial
        # flags.
        def moniker
          []
        end

        # Public: Returns an Array of Hashes representing switches for an
        # executable.
        # def switches
        #   keys = %i[label alias default]
        #   switch_plates.collect {|plate| keys.zip(plate).to_h }
        # end

        # Public: Array of default templates for switches.
        def switch_plates
          []
        end
      end

      # Public: Look up the label for rubric's default switches.
      def switch_label( switch )
        switches.alias(switch).label
      end

      def init( lyst )
        @cata = lyst
        sub_init
        build_switches cata
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

      private

      # Internal: Duckable initialisation.
      def sub_init
        nil
      end
    end
  end
end
