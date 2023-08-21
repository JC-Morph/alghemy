require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/properties'

module Alghemy
  module Transmutations
    # Public: Transmute Matter into Raw Matter or vice-versa.
    class Sublimate < Ancestors[:transmutation]
      def sub_init
        tree = lmnt.raw? ? remember : hoist_anchors
        @stuff = tree.merge stuff
      end

      def remember
        tree = lmnt.inherit(%i[affinity list], transform: 'sublimate')
        list = tree[:list]
        tree[:ext] = list ? list.first_lmnt.ext : affinity.defaults[:ext]

        tree.merge! lmnt.inherit(anchors, transform: 'sublimate')
        stuff[:affinity] ||= tree[:affinity] || :image
        stuff[:size]       = agree_size tree
        tree
      end

      def hoist_anchors
        tree = anchors.each.with_object({}) do |asp, hsh|
          hsh[asp] = lmnt.send(asp)
        end
        {ext: affinity.defaults[:raw_ext]}.merge tree
      end

      def anchors
        affinity.aspects.except(:len, :span).map(&:to_sym)
      end

      private

      def affinity
        aff = stuff[:affinity]
        return lmnt.class unless aff
        Affinities[aff]
      end

      def agree_size( tree )
        @mult = true if shrunk?(tree)
        Properties[:space].new(stuff[:size], tree[:size])
      end

      def shrunk?( tree )
        return unless stuff[:affinity] == :image
        %i[size depth].any? do |asp|
          stored = stuff[asp]
          fresh  = tree[asp]
          next unless stored && fresh
          stored < fresh
        end
      end
    end
  end
end
