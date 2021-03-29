require_relative 'algput/algdir'
require_relative 'algput/archivist'

module Alghemy
  # Internal: Output class for alghemical processes.
  class Algput
    attr_reader :enum, :parts

    # Internal: Initialise an Algput.
    #
    # lyst - Hash of initialisation options:
    #        :enum   - Enumerator method for Tome. Changes depending on how the
    #                  input file(s) should be enumerated.
    #        :sijil  - Filename of input.
    #        :ext    - Filename extension for output.
    #        :label  - String identifier for mutations (optional).
    #        :tran   - The name of the current Transmutation.
    #        :plural - Boolean if the transmutation is expected to create
    #                  multiple files.
    def initialize( lyst = {} )
      @enum  = lyst[:enum] || :lmnt
      @parts = {dir: lyst[:sijil].label, ext: lyst[:ext]}
      tune_parts lyst
      parts[:dir] = open_dir
    end

    def dir
      parts[:dir]
    end

    private

    # Internal: Define appropriate parts for creating outputs.
    #
    # lyst - Hash including relevant parameters:
    #        :sijil  - Filename of input.
    #        :label  - String identifier for mutations (optional).
    #        :tran   - The name of the current Transmutation.
    #        :plural - Boolean if the transmutation is expected to create
    #                  multiple files.
    def tune_parts( lyst )
      sijil = lyst[:sijil]
      ident = get_id lyst
      ident = extend_id(sijil, ident)
      if lyst[:plural]
        # TODO: different names possible here? Mutest
        parts[:base] = sijil.label unless sijil.plural?
        parts[:base].concat('_' + lyst[:glob]) if lyst[:glob]
        parts[:dir].concat(File::SEPARATOR + ident)
      else
        parts[:base] = ident
      end
    end

    # Internal: Get ident for the current transform.
    #
    # lyst - Hash including relevant parameters:
    #        :label  - String identifier for mutations. (optional)
    #        :tran   - The name of the current Transmutation.
    #
    # Returns String.
    def get_id( lyst )
      lyst[:label] || lyst[:tran].to_s[0..2]
    end

    # Internal: Take any existing idents from sijil and combine them with the
    # new ident.
    #
    # sijil - Filename of input.
    # ident - Short String to represent a transmutation in a Filename.
    #
    # Returns new ident as String.
    def extend_id( sijil, ident )
      Archivist.extend_id(sijil, ident)
    end

    def open_dir
      Algdir.open dir
    end
  end
end
