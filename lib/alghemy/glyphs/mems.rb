require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Bestows a simple memory function, allowing awareness of previous
    # states.
    class Mems < Array
      extend Methods[:deepclone]
      include Methods[:alget]
      attr_reader :tran, :lvl

      # Public: Constructor. Deepclones mems to ensure they are not accidentally
      # mutated. Preferred initialiser.
      def self.clonefreeze( mems )
        new(deepclone(mems))
      end

      # Public: Recover an aspect of a memory, with the option of disregarding
      # specific affinities.
      def inherit( asp, except = :Raw )
        mem = slice mem_index(except)
        return recall(asp, mem) unless asp.is_a?(Array)
        asp.each.with_object({}) do |a, hsh|
          hsh[a] = recall(a, mem)
        end
      end

      # Public: Reverses remembered transmutations in reverse chronological
      # order, attempting to revert the Object to a previous state.
      def revert( matter, levels = size )
        memories = self.class.deepclone self
        levels.times do
          @tran, @lvl = memories.shift
          transform  = alget(:REVERTABLE)[tran.to_sym]
          next if transform.nil?
          puts "reverting #{transform}"
          cata = revert_catalysts memories, matter

          # Reverse Transmutation.
          matter = matter.send(transform, cata)
        end
        matter
      end

      private

      # Internal: Find first mem which is not of type `except`.
      def mem_index( except )
        index do |mem|
          !type(mem).to_s[/#{except.to_s}/]
        end
      end

      # NOTE: STRUCTURE DEPENDENT METHODS
      # Internal: Recall type from mem.
      def type( mem )
        recall(:extype, mem).last
      end

      # Internal: Recall aspect from mem.
      def recall( asp, mem )
        asp == :method ? mem[0] : mem[1][asp]
      end

      # Internal: Reorder mem for passing to a Transmutant as a reversion.
      def revert_catalysts( memories, matter )
        cata = {ext: lvl[:extype].first, label: '(R)'}
        cata = yuv_parse(cata, matter)
        [:ents, :enc, :bit].each do |opt|
          cata[opt] = lvl[opt].reverse if lvl[opt]
        end
        cata[:memrec] = memories.empty? ? false : memories
        lvl.merge cata
      end

      # Internal: Yuv specific alterations to dimensions during sublimation.
      # TODO: make a place for this where it makes sense
      def yuv_parse( hsh, matter )
        return hsh unless matter.sijil.ext == '.yuv' && tran == :sublimate
        x, y = lvl[:space].dims.collect {|n| n.odd? ? n.succ : n }
        hsh.merge space: [x, y]
      end
    end
  end
end
