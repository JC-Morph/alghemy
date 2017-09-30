require_relative 'tools'

# Default values and related classes for Matter of the Sound affinity
module SoundConstants
  def aspects
    %i[time freq lifespan depth arcana]
  end

  def defaults
    {raw_ext: '.pcm'}
  end

  def tests
    [/FAIL/]
  end

  def tools
    Tools.new(Slay, Eye, Sock)
  end
end
