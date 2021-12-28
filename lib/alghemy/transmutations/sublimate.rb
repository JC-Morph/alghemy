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
        tree[:ext] = tree[:list] ?
          tree[:list].first_lmnt.ext :
          affinity.defaults[:ext]

        stuff[:affinity] ||= tree[:affinity] || :image
        tree.merge! lmnt.inherit(anchors, transform: 'sublimate')
        stuff[:size] = agree_size tree
        tree
      end

      def hoist_anchors
        tree = anchors.each.with_object({}) do |asp, hsh|
          hsh[asp] = lmnt.send(asp)
        end
        {ext: affinity.defaults[:raw_ext]}.merge tree
      end

      def anchors
        rejects = /^(len|span)$/
        aspects = affinity.aspects.reject {|asp| asp[rejects] }
        aspects.collect(&:to_sym)
      end

      private

      def affinity
        return lmnt.class unless stuff[:affinity]
        Affinities[stuff[:affinity]]
      end

      def agree_size( tree )
        size = Properties[:space].call(stuff[:size], tree[:size])
        @mult = true if shrunk?(tree)
        size
      end

      def shrunk?( tree )
        return unless stuff[:affinity] == :image
        %i[size depth].any? do |asp|
          next unless stuff[asp] && tree[asp]
          stuff[asp] < tree[asp]
        end
      end
    end
  end
end
