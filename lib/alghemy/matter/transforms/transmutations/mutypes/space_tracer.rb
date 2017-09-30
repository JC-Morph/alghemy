# Space initialising method for Transmutations
module SpaceTrace
  def space_trace( cata, tree )
    return unless tree.keys.include? :space
    space = Space.trace(cata[:space], tree[:space])
    cata[:space] = space
  end
end
