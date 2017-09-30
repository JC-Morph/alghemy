require_relative 'tome'
require_relative 'grimoire'

# An indexed collection of Grimoires
class Metamoire < Tome
  alias each_group each
  alias _transpose transpose

  # Constructor method; parses structure according to dims,
  # and populates self with Grimoires.
  # Preffered initialisation method.
  def self.scribe( list, dims )
    groups = list.size / dims
    lmnts  = list.dup
    meta   = groups.times.with_object([]) do |_, arr|
      arr << lmnts.shift(dims)
    end
    new(meta).liberate
  end

  # Converts all elements to Grimoires.
  def liberate
    collect {|arr| Grimoire.scribe(arr) }
  end

  # Transpose self, equivalent of Array#transpose.
  def transpose
    self.class.new(_transpose).liberate
  end

  # Enumerator method for every element in elements.
  def each_lmnt( &block )
    return each {|grim| grim.each(&block) } if block_given?
    each.with_object([]) do |grim, arr|
      grim.each {|lmnt| arr << lmnt }
    end.to_enum
  end

  # Returns the first lowest element.
  def first_lmnt
    place = __callee__.to_s[/^[a-z]+/]
    send(place).send(place)
  end
  alias last_lmnt first_lmnt
end
