require_relative 'tools'

# Default values and related classes for Matter of the Video affinity
module VideoConstants
  def aspects
    %i[space time freq lifespan arcana]
  end

  def defaults
    {raw_ext: '.raw'}
  end

  def tests
    [
      /valid data/,
      %r{ration: N/A},
      'am #\d:\d.*: Vid',
      /Input #\d, image2,/
    ]
  end

  def tools
    Tools.new(Fflay, Probe, Ffock)
  end
end
