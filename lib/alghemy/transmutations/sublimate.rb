require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Transmutations
    # Public: Transmute Matter into Raw Matter or vice-versa.
    class Sublimate < Ancestors[:transmutation]
      include Methods[:space_trace]

      def sub_init
        tree = lmnt.raw? ? inherit : hoist_anchors
        tree[:ext] ||= type.defaults[:raw_ext]
        @cata = tree.merge cata
      end

      def inherit
        tree = lmnt.inherit %i[ext type]
        cata[:type] ||= tree[:type]
        tree.merge! lmnt.inherit(anchors)
        space_trace(cata, tree)
        shrink_check tree
      end

      def hoist_anchors
        anchors.each.with_object({}) do |asp, hsh|
          hsh[asp] = lmnt.send(asp)
        end
      end

      def anchors
        rejects = /^(time|lifespan|arcana)$/
        asps = type.aspects.reject {|k| k[rejects] }
        asps.collect(&:to_sym)
      end

      private

      def type
        cata[:type] || lmnt.class
      end

      def shrink_check( tree )
        return tree unless type == Affinities[:image]
        shrunk = %i[space depth].any? do |asp|
          tree[asp] > cata[asp] if tree[asp] && cata[asp]
        end
        @solution = Affinities[:elements] if shrunk
        tree
      end
    end
  end
end
