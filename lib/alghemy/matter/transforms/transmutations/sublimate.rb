require_relative 'transmutation'
require_relative 'mutypes/space_tracer'

# Transmute Matter into Raw Matter or vice-versa
class Sublimate < Transmutation
  include SpaceTrace

  def sub_init
    tree = lmnt.raw? ? inherit : lmntree
    tree[:ext] ||= type.defaults[:raw_ext]
    @cata        = tree.merge cata
  end

  def inherit
    tree   = {}
    extype = lmnt.inherit :extype
    return tree if extype.empty?
    unless cata[:type]
      tree[:ext]  = extype[0]
      cata[:type] = extype[1]
    end
    tree.merge! lmnt.inherit(subasps)
    space_trace(cata, tree)
    shrink_check tree
  end

  def lmntree
    subasps.each.with_object({}) do |asp, hsh|
      hsh[asp] = lmnt.send(asp)
    end
  end

  private

  def type
    cata[:type] || lmnt.class
  end

  def subasps
    rejects = /^(time|lifespan|arcana)$/
    asps = type.aspects.reject {|k| k[rejects] }
    asps.collect(&:to_sym)
  end

  def shrink_check( tree )
    return tree unless type == Image
    shrunk = %i[space depth].any? do |asp|
      tree[asp] > cata[asp] if tree[asp] && cata[asp]
    end
    @solution = Elements if shrunk
    tree
  end
end
