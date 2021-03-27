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
      def self.clonefreeze( mems = nil )
        mems ? new(deepclone(mems)) : new
      end

      # Public: Attempt to recall an aspect of a memory, optionally
      # disregarding memories of specified affinities.
      def recall( aspect, **kwargs )
        mem = slice mem_index(**kwargs)
        return recover(aspect, mem) unless [aspect].flatten.size > 1
        aspect.each.with_object({}) do |asp, hsh|
          next unless mem
          hsh[asp] = recover(asp, mem)
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

      # Internal: Find first mem which is either from a specified :transform,
      # or from when element did not have the affinity :except.
      #
      # Returns Integer.
      def mem_index( except: 'Raw', transform: nil )
        return 0 if size == 0
        return transpose[0].index(transform) if transform
        index do |mem|
          !recover(:affinity, mem)[/#{except}/]
        end
      end

      # NOTE: STRUCTURE DEPENDENT METHODS?

      # Internal: Recover aspect from mem.
      def recover( asp, mem )
        asp == :method ? mem[0] : mem[1][asp]
      end

      # Internal: Reorder mem for passing to a Transmutation as a reversion.
      def revert_catalysts( memories, matter )
        cata = {ext: lvl[:ext], label: 'R'}
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
