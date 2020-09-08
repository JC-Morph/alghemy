require 'alghemy/factories'
require 'alghemy/modules'
require_relative 'transmutation/memrec'
require_relative 'transmutation/algput'

module Alghemy
  module Ancestors
    # Public: Base class for processes that change Matter in some way, creating
    # one or more new files and returning new Matter.
    class Transmutation
      include Modules[:osman]
      include Memrec
      attr_reader :lmnt, :cata

      # Internal: Initialise a Transmutant.
      #
      # lmnt - The Matter to build the transform for.  Expected to represent
      #        part of the input for the transform.
      # lyst - Hash of initialisation options. (default: {})
      def initialize( lmnt, lyst = {} )
        @solution = lmnt.class
        @tome     = lmnt.list
        @lmnt     = lmnt

        @cata = lyst.merge tran: tran
        sub_init
        prepext
      end

      # Internal: Initialises Algput to define output environment, then Rubric
      # to define the process String. Invoke Tome with Algput & Rubric to create
      # new files, then evoke new instance of Matter.
      #
      # Returns new instance of Matter.
      def implement
        algput  = Algput.new cata.merge(put_lyst)
        process = write_rubric
        heard   = @tome.invoke(algput, process)
        evoke(list(heard), process)
      end

      # Internal: Evoke new Matter from Tome with memories from Rubric.
      #
      # tome   - Tome of filenames that were heard during transmutation.
      # rubric - Rubric used for transmutation; #memrec (memory-recording) duck.
      #
      # Returns new instance of Matter.
      def evoke( tome, rubric )
        tome_error if tome.empty?
        sijil = tome.size < 2 ? tome.first : tome.globvert
        sijil.limit tome.size
        sijil.evoke memrec(lmnt.mems, m_cat(rubric))
      end

      # Internal: Returns a Tome of all files in Array.
      #
      # arr - Array containing Strings of filenames.
      def list( arr )
        Factories[:scribe].call arr
      end

      private

      # Internal: Merges default values with @cata. Serves as duckable
      # initialisation for transforms without default values.
      def sub_init
        @cata = defaults.merge cata
        tran_init
      end

      # Internal: Returns Hash of default values for @cata that can be
      # overridden.
      def defaults
        {ext: lmnt.sijil.ext}
      end

      # Internal: Second-tier duckable initialisation.
      def tran_init
        raise NotImplementedError
      end

      # Internal: Returns String containing Transmutation class name.
      def tran
        self.class.name.split('::').last.downcase
      end

      def m_cat( rubric )
        m_cat = {extype: [lmnt.sijil.ext, lmnt.class]}
        subasps.each do |asp|
          defunct = rubric.swist.keys.any? do |switch|
            asp == switch_label(switch)
          end
          m_cat[asp] = cata[asp] unless defunct
        end
        m_cat.merge rubric.swist
      end

      def subasps
        {}
      end

      # Internal: Prepend extension with period if not already present.
      def prepext
        cata[:ext].prepend('.') if cata[:ext][/^[^\.]/]
      end

      # Internal: Returns Hash with variables specific to Algput initialisation.
      def put_lyst
        {sijil: lmnt.sijil, plural: plural?}
      end

      # Internal: Boolean if expected output Class ends with an 's'. Denotes
      # whether output is expected to consist of more than one file.
      def plural?
        !(@solution.to_s =~ /s$/).nil?
      end

      def tome_error
        msg = 'No created files found! Increase Alghemy.ear_sleep if problem ' \
          'persists.'
        raise msg
      end
    end
  end
end
