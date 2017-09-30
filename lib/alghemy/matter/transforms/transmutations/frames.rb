require_relative 'transmutation'

# Extract Images from a Video
class Frames < Transmutation
  def rubriclass
    Ffock
  end

  def tran_init
    cata[:glob]   ||= frames_less_than(1_000) ? '%03d' : '%04d'
    cata[:freq]     = lmnt.freq if lmnt.is_a?(Video)
    @solution = Elements unless frames_less_than 2
  end

  private

  def defaults
    {ext: '.png'}
  end

  def frames_less_than( frames )
    lmnt.is_a?(Video) && lmnt.lifespan < frames
  end
end
