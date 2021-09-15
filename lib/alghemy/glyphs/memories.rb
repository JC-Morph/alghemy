require 'forwardable'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Bestows a simple memory function, allowing awareness of previous
    # states.
    class Memories
      extend Forwardable
      extend Methods[:deepclone]
      include Methods[:alget]
      def_delegators :@list, :empty?, :index, :size
      attr_reader :list

      # Public: Constructor. Deepclones mems to ensure they are not accidentally
      # mutated. Preferred initialiser.
      def self.clonefreeze( mems = nil )
        mems ? new(deepclone(mems)) : new
      end

      def pretty_print( pp )
        pp.pp list
      end

      def initialize( mems = nil )
        @list = mems || []
      end

      def slice( this )
        return list[this] if this.is_a?(Integer)
        list.select {|mem| mem[:name] == this.to_sym }
      end
      alias_method :[], :slice

      # Public: Attempt to recall an aspect of a memory, optionally
      # disregarding memories of specified affinities.
      def recall( aspect, options )
        mem = mem_search(**options) || {}
        return mem[aspect] unless [aspect].flatten.size > 1
        mem.select {|asp| aspect.any? asp }
      end

      # Public: Reverses remembered transmutations in reverse chronological
      # order, attempting to revert the Object to a previous state.
      def revert( matter, levels = size )
        memories = self.class.deepclone list
        levels.times do
          transform = memories.last[:name]
          reversion = alget(:REVERTABLE)[transform]
          memories.pop && next if reversion.nil?
          puts "reverting #{transform}"

          args = rebuild_args(memories, matter.sijil)
          # Reverse Transmutation.
          matter = matter.send(reversion, **args)
        end
        matter
      end

      private

      # Internal: Find last mem which is either from a specified :transform,
      # or from when element did not have the affinity :except.
      #
      # Returns Integer.
      def mem_search( transform: nil, except: 'Raw' )
        return if empty?
        return slice(transform).last if transform
        list.reject {|mem| mem[:affinity][/#{except}/] }.last
      end

      # Internal: Build arguments from a memory for passing to a Transmutation
      # as a reversion.
      def rebuild_args( memories, sijil )
        memory = memories.pop
        memory[:ext] = memory[:sijil].ext
        yuv_tweak(memory, sijil)
        memory.invert.merge label: 'R', record: false
      end

      # Internal: Yuv specific alterations to dimensions during sublimation.
      # TODO: put this where it makes sense
      def yuv_tweak( memory, sijil )
        return unless sijil.ext == '.yuv'
        size = memory[:size].dims.map {|dim| dim.odd? ? dim.succ : dim }
        memory[:size] = size
      end
    end
  end
end
