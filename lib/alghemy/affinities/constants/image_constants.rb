require_relative 'tools'

# Public: Constants and Classes for the Image affinity.
module ImageConstants
  def aspects
    %i[space depth arcana]
  end

  def defaults
    {raw_ext: '.rgb'}
  end

  def tests
    [%r{error/.+}, %r{=>.+([\./-]\w+)+\[\d+\]}]
  end

  def tools
    Tools.new(View, Scry, Spell)
  end
end
