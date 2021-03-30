require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Transmutations
    # Public: Transmute Matter into Raw Matter or vice-versa.
    class Sublimate < Ancestors[:transmutation]
      include Methods[:space_trace]

      def sub_init
        tree = lmnt.raw? ? remember : hoist_anchors
        tree[:ext] ||= affinity.defaults[:raw_ext]
        @cata = tree.merge cata
      end

      def remember
        tree = lmnt.inherit(%i[ext affinity], transform: 'sublimate')
        cata[:affinity] ||= tree[:affinity]
        tree.merge! lmnt.inherit(anchors, transform: 'sublimate')
        space_trace(cata, tree)
        shrink_check tree
      end

      def hoist_anchors
        anchors.each.with_object({}) do |asp, hsh|
          hsh[asp] = lmnt.send(asp)
        end
      end

      def anchors
        rejects = /^(len|span|arcana)$/
        aspects = affinity.aspects.reject {|asp| asp[rejects] }
        aspects.collect(&:to_sym)
      end

      private

      def affinity
        return lmnt.class unless cata[:affinity]
        Affinities[cata[:affinity]]
      end

      def shrink_check( tree )
        return tree unless affinity == Affinities[:image]
        shrunk = %i[size depth].any? do |asp|
          tree[asp] > cata[asp] if tree[asp] && cata[asp]
        end
        @solution = Affinities[:elements] if shrunk
        tree
      end
    end
  end
end
