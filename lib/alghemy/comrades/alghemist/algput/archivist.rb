require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  # Internal: Builds transform-specific Strings to use in Sijils.
  module Archivist
    class << self
      include Methods[:alget]
      attr_reader :sijil, :ident, :idents

      # Public: Take any existing idents from sijil and combine them with the
      # new ident.
      #
      # sijil - Filename of input.
      # ident - Short String to represent a Transmutation in a Filename.
      #
      # Returns idents as a joined String.
      def extend_id( sijil, ident )
        @sijil = Glyphs[:sijil].compose sijil
        @ident = ident
        find_ids and add_ident
        idents.join('-')
      end

      private

      # Internal: Find pre-existing idents in Sijil.
      def find_ids
        @idents = []
        list   = dir_ident_search
        list ||= sijil.unglob.base.sub(sijil.label, '')
        @idents = list.split '-' unless list[/^\./]
      end

      # Internal: Add ident in the correct manner, depending on the type.
      def add_ident
        ident[mutation] ? add_mutation : add_transposition
      end

      # Internal: Add mutation ident.
      def add_mutation
        return add_transposition unless consecutive_mutation?
        return add_number if consecutive_mutation?(ident)
        idents.last.concat ident
      end

      # Internal: Add transposition ident.
      def add_transposition
        return add_number if ident == idents.last
        return idents[-1] = 'suso' if suso?
        idents << ident
      end

      # Internal: Increment a number for ident repetitions.
      def add_number
        last = idents.last
        return last.succ! if last[/\d$/]
        last.insert(-1, '2')
      end

      # Internal: Boolean if the last ident was a mutation. Ident must also
      # match id, if present.
      #
      # id - See #mutation. (optional)
      def consecutive_mutation?( id = nil )
        last_id = idents.last
        last_id && (last_id =~ mutation(id)) ? true : false
      end

      # Internal: Construct a Regexp for a mutation ident.
      #
      # id - String label for a mutation, represented by an uppercase character.
      #
      # Returns Regexp.
      def mutation( id = nil )
        id ||= '[A-Z]'
        /[A-Z]*#{id}\d{0,2}$/
      end

      # Internal: Attempt to find idents in dir.
      def dir_ident_search
        dirs  = sijil.dir.split alget(:SEP)
        index = dirs.index {|dir| dir == alget(:ROOT) }
        return unless index && dirs[index..].size > 2
        dirs[index + 2]
      end

      def suso?
        ident == 'soni' && idents.last == 'subl'
      end
    end
  end
end
