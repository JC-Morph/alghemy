require_relative 'transmutation'

# Perform an inverse fourier transform with image magick
class Ift < Transmutation
  def rubriclass
    Ffell
  end

  def tran_init
    cata[:enum] = :group
    @tome     = sub_tome if cata[:magni] || cata[:phase]
    @solution = Element if @tome.size == 2
  end

  private

  # Define Tome to be used.
  def sub_tome
    tome = %i[magni phase].collect do |lmnt|
      lmnt = cata[lmnt] || cata[:tome]
      lmnt.is_a?(Array) ? lmnt : lmnt.list
    end.transpose
    tome.flatten! if tome.size == 1
    list tome
  end
end
