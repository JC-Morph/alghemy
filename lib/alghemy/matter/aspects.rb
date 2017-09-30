require 'ostruct'
require_relative 'aspects/clasps'

# Public: Inclusion module. Aspect functionality and lookup. Extends class with
# Clasps.
module Aspects
  # Internal: Extends class with Clasps Module.
  #
  # base - Class that included self.
  def self.included( base )
    base.extend Clasps
  end

  # Public: Aspect calculator, updates Hash of aspects.
  #
  # asp - String naming the aspect to calculate. Should be included in #aspects.
  #
  # Returns individual aspect if specified. If no aspect is specified, returns
  # a Hash of all the aspects that have been calculated.
  def asps( asp = nil )
    @asps ||= {}
    return @asps unless asp
    return @asps[asp] if @asps[asp]
    @asps[asp] = perceive asp
  end

  # Internal: Duck for aspect calculation method. Expected of class; typically
  # Matter.
  def perceive( _asp )
    raise NotImplementedError
  end

  # Public: Returns boolean if class has no aspects defined.
  def raw?
    self.class.aspects.empty?
  end
end
