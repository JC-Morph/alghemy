require_relative 'rubric'

# Define an Array for a command passed
#  to the image magick processing utility
class Spell < Rubric
  def self.defaults
    {vorh: :vertical}
  end

  def sublimate
    process = cata[:raw] ? [size, depth] : []
    process << [input, output]
  end

  def append
    [input, vorh + 'append', output]
  end

  private

  def moniker
    ['convert']
  end

  def size
    ['-size', cata[:space]]
  end

  def depth
    ['-depth', cata[:depth]]
  end

  def vorh
    cata[:vorh].to_s[/^v/i] ? '-' : '+'
  end
end
