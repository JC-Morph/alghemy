require_relative 'rubric'

# Define an Array for a command passed
#  to the ffmpeg video processing utility
class Ffock < Rubric
  def self.defaults
    {vora: 'a', quality: 3}
  end

  def sublimate
    [input, output]
  end

  def frames
    [input, type('image2'), quality, output]
  end

  def compile
    [formats, rate, input, output]
  end

  def rip
    [input, vora, output]
  end

  private

  def moniker
    %w[ffmpeg -loglevel warning -stats]
  end

  def input
    input = %w[-i %{input}]
    return input unless cata[:raw]
    [formats, size, rate, input]
  end

  def formats
    [format, pix_fmt]
  end

  def format
    type cata[:format]
  end

  def type( var = nil )
    ['-f', var || 'rawvideo']
  end

  def pix_fmt
    p_fmt = cata[:p_fmt]
    p_fmt ? ['-pix_fmt', p_fmt] : []
  end

  def size
    ['-video_size', cata[:space]]
  end

  def rate
    ['-framerate', cata[:freq].to_s]
  end

  def quality
    ['-q:v', cata[:quality].to_s]
  end

  def vora
    cata[:vora][/^v/i] ? '-an' : '-vn'
  end
end
