require 'alghemy/methods'
require_relative 'algput/archivist'

module Alghemy
  # Internal: Output class for alghemical processes.
  class Algput
    include Methods[:alget]
    attr_reader :enum, :tome, :sijil, :parts

    # Internal: Initialise an Algput.
    #
    # stuff - Hash of initialisation options:
    #        :enum   - Enumerator method for Tome. Changes depending on how the
    #                  input file(s) should be enumerated.
    #        :sijil  - Filename of input.
    #        :ext    - Filename extension for output.
    #        :label  - String identifier for mutations (optional).
    #        :name   - The name of the current Transmutation.
    def initialize( stuff = {} )
      @enum  = stuff[:enum]  || :lmnt
      @tome  = stuff[:tome]
      @sijil = stuff[:sijil] || tome.sijil
      @parts = {dir: sijil.label, seq: stuff[:seq], ext: stuff[:ext]}
      tune_parts stuff
      parts[:dir] = open_dir
    end

    def next_batch
      parts[:seq].succ! if parts[:seq]
      parts
    end

    def dir
      parts[:dir]
    end

    private

    # Internal: Define appropriate parts for creating outputs.
    #
    # stuff - Hash including relevant parameters:
    #        :label  - String identifier for mutations (optional).
    #        :name   - The name of the current Transmutation.
    #        :mult   - Boolean if the transmutation is expected to create
    #                  multiple files.
    def tune_parts( stuff )
      ident = get_id stuff
      ident = extend_id ident
      if stuff[:mult]
        add_sequence
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
    # ident - Short String to represent a transmutation in a Filename.
    #
    # Returns new ident as String.
    def extend_id( ident )
      Archivist.extend_id(sijil, ident)
    end

    def add_sequence
      return if tome.size.between?(1, tome.entries.map(&:to_s).uniq.size)
      parts[:seq] ||= "_#{'0' * tome.size.to_s.size}"
    end

    def open_dir
      root = alget(:ROOT)
      dir = self.dir.to_s
      dir = File.join(root, dir) unless dir[/^#{root}/]
      FileUtils.makedirs dir
      dir
    end
  end
end
