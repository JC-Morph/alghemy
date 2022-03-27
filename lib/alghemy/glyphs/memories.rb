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
      def_delegators :@list, :empty?, :each, :index, :size
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

      # Public: Attempt to recall an aspect of a memory, optionally disregarding
      # memories of specified affinities.
      #
      # aspect  - Aspect to recall. Expected to be a key in a Memory Hash.
      # options - Hash of optional arguments.
      #           :transform - Only search in Memories with a stored :name that
      #                        matches this variable.
      #           :except    - Only search in Memories with a stored :affinity
      #                        that doesn't match this variable.
      def recall( aspect, options )
        aspect_list = [aspect].flatten
        aspects     = aspect_search(aspect_list, **options)
        return aspects unless aspect_list.size == 1
        aspects.values.last
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

          args = rebuild_args(memories, matter.list)
          # Reverse Transmutation.
          matter = matter.send(reversion, **args)
        end
        matter
      end

      private

      # Internal: Find last mem which is either from a specified :transform,
      # or from when element did not have the affinity :except.
      #
      # For documentation of the arguments, see #recall.
      def aspect_search( aspect, transform: nil, except: 'Raw' )
        return {} if empty?
        list = transform ? slice(transform) : self.list
        list.reject! {|mem| mem[:affinity][/#{except}/] }
        aspect.each.with_object({}) do |asp, hsh|
          values = list.map {|mem| mem[asp] }
          value  = values.compact.last
          next unless value
          hsh[asp] = value
        end
      end

      # Internal: Build arguments from a memory for passing to a Transmutation
      # as a reversion.
      def rebuild_args( memories, list )
        memory = memories.pop
        memory[:ext] = memory[:list].first_lmnt.ext
        yuv_tweak(memory, list)
        memory.invert.merge label: 'R', record: false
      end

      # Internal: Yuv specific alterations to dimensions during sublimation.
      # TODO: put this where it makes sense
      def yuv_tweak( memory, list )
        return unless list.first.ext == '.yuv'
        size = memory[:size].dims.map {|dim| dim.odd? ? dim.succ : dim }
        memory[:size] = size
      end
    end
  end
end
