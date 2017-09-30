require_relative 'transmutation'

# Perform a fast fourier transform with image magick
class Fft < Transmutation
  def rubriclass
    Ffell
  end

  def tran_init
    @solution = Elements
  end

  private

  def defaults
    {ext: '.png'}
  end
end
