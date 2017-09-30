# Internal: Builds transform-specific Strings to use in Sijils.
module Occultist
  class << self
    attr_reader :sijil, :ident, :idents

    # Public: Abstract any existing idents from sijil, then add new ident.
    #
    # sijil - Sijil, presumed to be an input.
    # ident - Short String, relating to a transform.
    #
    # Returns idents as a String.
    def extend_id( sijil, ident )
      @sijil = sijil
      @ident = ident
      find_ids
      ident[mute] ? add_mute : add_pose
      idents * '-'
    end

    # Internal: Add transposition ident.
    def add_pose
      return add_number if ident == idents.last
      idents << ident
    end

    # Internal: Add mutation ident.
    def add_mute
      return add_pose unless mute_defined?
      return add_number if mute_defined? ident
      idents.last.concat ident
    end

    private

    # Internal: Find prexisting idents in Sijil.
    def find_ids
      @idents = []
      ident   = dir_ident
      ident << sijil.base_num if ident && sijil.base_num
      ident ||= sijil.unglob.base.sub(sijil.label, '')
      @idents = ident.split '-' unless ident[/^\./]
    end

    # Internal: Attempt to find idents in dir.
    def dir_ident
      dirs  = sijil.dir.split SEP
      index = dirs.index {|dir| dir == LEADR }
      return unless index && dirs[index..-1].size > 2
      dirs[index + 2]
    end

    # Internal: Construct a Regexp for a mutation ident.
    #
    # id - String label for a mutation. Usually represented by a capital letter
    #      between round brackets.
    #
    # Returns Regexp.
    def mute( id = nil )
      id ||= '[A-Z]'
      id   = id[1] if id[/^\(/]
      /\(#{id}\d{0,2}\)$/
    end

    # Internal: Was the last ident a mutation, matching id?
    #
    # id - See #mute.
    #
    # Returns Boolean.
    def mute_defined?( id = nil )
      return false unless idents.last
      !(idents.last =~ mute(id)).nil?
    end

    # Internal: Increment a number for ident repetitions.
    def add_number
      last = idents.last
      return last.succ! if last[/\d\)*$/]
      last.insert(mute_defined? ? -2 : -1, '2')
    end
  end
end
