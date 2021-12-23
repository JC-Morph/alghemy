require_relative 'algput/algdir'
require_relative 'algput/archivist'

module Alghemy
  # Internal: Output class for alghemical processes.
  class Algput
    attr_reader :enum, :parts

    # Internal: Initialise an Algput.
    #
    # stuff - Hash of initialisation options:
    #        :enum   - Enumerator method for Tome. Changes depending on how the
    #                  input file(s) should be enumerated.
    #        :sijil  - Filename of input.
    #        :ext    - Filename extension for output.
    #        :label  - String identifier for mutations (optional).
    #        :name   - The name of the current Transmutation.
    #        :plural - Boolean if the transmutation is expected to create
    #                  multiple files.
    def initialize( stuff = {} )
      @enum  = stuff[:enum] || :lmnt
      @parts = {dir: stuff[:sijil].label, ext: stuff[:ext]}
      tune_parts stuff
      parts[:dir] = open_dir
    end

    def dir
      parts[:dir]
    end

    private

    # Internal: Define appropriate parts for creating outputs.
    #
    # stuff - Hash including relevant parameters:
    #        :sijil  - Filename of input.
    #        :label  - String identifier for mutations (optional).
    #        :name   - The name of the current Transmutation.
    #        :mult   - Boolean if the transmutation is expected to create
    #                  multiple files.
    def tune_parts( stuff )
      sijil = stuff[:sijil]
      ident = get_id stuff
      ident = extend_id(sijil, ident)
      if stuff[:mult]
        # TODO: different names possible here? Mutest
        parts[:base] = sijil.label unless sijil.plural?
        parts[:base].concat('_' + stuff[:glob]) if stuff[:glob]
        parts[:dir].concat(File::SEPARATOR + ident)
      else
        parts[:base] = ident
      end
    end

    # Internal: Get ident for the current transform.
    #
    # stuff - Hash including relevant parameters:
    #        :label  - String identifier for mutations. (optional)
    #        :name   - The name of the current Transmutation.
    #
    # Returns String.
    def get_id( stuff )
      stuff[:label] || stuff[:name].to_s[0..2]
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
