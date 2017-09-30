require_relative 'sijil/filename'

# Directly references the location of Matter
class Sijil < String
  include Filename

  def self.compose( sijil )
    match_error(sijil) if Dir.glob(sijil).empty?
    new sijil
  end

  def self.match_error( sijil )
    raise IOError, "Cannot find any files matching: #{sijil}"
  end

  def list
    Dir.glob self
  end

  def first
    self.class.new list.send(__callee__)
  end
  alias last first

  def limit( to_size )
    return unless list.size > to_size
    list[to_size..-1].each {|lmnt| File.delete lmnt }
  end

  def plural?
    list.size > 1
  end

  def evoke( lyst = {} )
    Evoke.sijil( self, lyst )
  end

  def base_num
    base[/(?<=[_-])\d+$/]
  end

  def unglob
    gsub(/[_-]*(?<!\\)[\*\?]+/, '')
  end

  def ffglob
    glob = "_%0#{first.base_num.size}d"
    swap_parts base: unglob.base.concat(glob)
  end
end
