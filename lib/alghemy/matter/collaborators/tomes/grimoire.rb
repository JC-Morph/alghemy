require_relative 'tome'

# An indexed collection of Sijils
class Grimoire < Tome
  alias each_lmnt  each
  alias first_lmnt first
  alias last_lmnt  last

  # Constructor method, populates self with Sijils.
  # Preffered initialisation method.
  def self.scribe( list, _dims = nil )
    new(list).liberate
  end

  # Converts all elements to Sijils.
  def liberate
    collect {|sij| Sijil.new sij }
  end

  # Enumerator method for all elements.
  def each_group
    block_given? ? yield(self) : [self].to_enum
  end

  # Distill an appropriate output Sijil from Grimoire.
  def swap_parts( lyst = {} )
    # define abstracted Sijil and swap it's parts with lyst.
    sijil = globvert.swap_parts lyst
    # remove any identifiable glob patterns.
    sijil.unglob
  end
end
