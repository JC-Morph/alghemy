require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/glyphs'

module Alghemy
  module Transmutations
    # Public: Transmute Matter into Raw Matter or vice-versa.
    class Sublimate < Ancestors[:transmutation]
      def sub_init
        tree = lmnt.raw? ? remember : hoist_anchors
        @cata = tree.merge cata
      end

      def remember
        tree = lmnt.inherit(%i[ext affinity], transform: 'sublimate')
        cata[:affinity] ||= tree[:affinity] || :image
        tree.merge! lmnt.inherit(anchors, transform: 'sublimate')
        cata[:size] = agree_size tree
        {ext: affinity.defaults[:ext]}.merge tree
      end

      def hoist_anchors
        tree = anchors.each.with_object({}) do |asp, hsh|
          hsh[asp] = lmnt.send(asp)
        end
        {ext: affinity.defaults[:raw_ext]}.merge tree
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

      def agree_size( tree )
        size = Glyphs[:space].call(cata[:size], tree[:size])
        @solution = Affinities[:elements] if shrunk?(tree)
        size
      end

      def shrunk?( tree )
        return unless cata[:affinity] == :image
        %i[size depth].any? do |asp|
          next unless cata[asp] && tree[asp]
          cata[asp] < tree[asp]
        end
      end
    end
  end
end
