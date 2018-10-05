require 'alghemy/options'
require_relative 'algput/algdir'
require_relative 'algput/occultist'

module Alghemy
  # Internal: Output class for alghemical processes.
  class Algput
    attr_reader :enum, :parts

    # Internal: Initialise an Algput.
    #
    # lyst - Hash of initialisation options:            (default: {})
    #        :enum   - Enumerator method slug for Tome. (default: :lmnt)
    #        :sijil  - Sijil, presumed to be an input.
    #        :ext    - File extension for output.
    #        :label  - String identifier for mutations. (optional)
    #        :tran   - Symbol of current Transmutant.
    #        :plural - Boolean if transform expects to output Elements.
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
    #        :sijil  - Sijil, presumed to be an input.
    #        :label  - String identifier for mutations. (optional)
    #        :tran   - Symbol of current Transmutant.
    #        :plural - Boolean if transform expects to output Elements.
    def tune_parts( lyst )
      sijil = lyst[:sijil]
      ident = get_id lyst
      ident = extendid(sijil, ident)
      if lyst[:plural]
        parts[:base] = sijil.label unless sijil.plural?
        parts[:base].concat('_' + lyst[:glob]) if lyst[:glob]
        parts[:dir].concat(SEP + ident)
      else
        parts[:base] = ident
      end
    end

    # Internal: Get ident for the current transform.
    #
    # lyst - Hash including relevant parameters:
    #        :label  - String identifier for mutations. (optional)
    #        :tran   - Symbol of current Transmutant.
    #
    # Returns String.
    def get_id( lyst )
      lyst[:label] || lyst[:tran].to_s[0..2]
    end

    # Internal: Take any existing idents from sijil and combine them with ident.
    #
    # sijil - Sijil, presumed to be an input.
    # ident - Short String representing current transform.
    #
    # Returns new ident as String.
    def extendid( sijil, ident )
      Occultist.extend_id(sijil, ident)
    end

    def open_dir
      Algdir.open dir
    end
  end
end
