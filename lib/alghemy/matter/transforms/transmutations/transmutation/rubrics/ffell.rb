require_relative 'rubric'

# Define an Array for a command passed
#  to the image magick processing utility
class Ffell < Rubric
  def self.defaults
    {axis: :phase}
  end

  def fft
    [input, operator + __callee__.to_s, output]
  end
  alias ift fft

  private

  def moniker
    ['ffconvert']
  end

  def operator
    cata[:axis].to_s[/^(magni|phase)/i] ? '-' : '+'
  end
end
