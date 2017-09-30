require_relative 'rubric'

# Define an executable process for a command
#  passed to the sox sound processing utility
class Sock < Rubric
  def self.defaults
    {format: 'raw', rate: 48_000}
  end

  def sonify
    process = [format, rate, ents[0], input]
    process << [ents[1], output]
    # insert prefix unless sox recognises desired extension?
    unknown ? process.insert(4, type) : process
  end

  def visualise
    process = [ents[0], input]
    process << [format, ents[1], output]
    cata[:raw] ? process.insert(2, [type, rate]) : process
  end

  def append
    ['%{input}', output]
  end

  private

  def moniker
    # make dither optional
    %w[sox -V1 -D]
  end

  def format
    type cata[:format]
  end

  def type( var = nil )
    ['-t', var || self.class.defaults[:format]]
  end

  def rate
    ['-r', cata[:rate]]
  end

  def ents
    cata[:ents].collect do |enc, bit|
      ['-e', enc, '-b', bit]
    end
  end

  def unknown( ext = cata[:ext] )
    ext = ext[1..-1] if ext[/^\./]
    raw = `sox --help-format #{ext}`.split("\n")[1]
    !(raw =~ /^Cannot/).nil?
  end
end
