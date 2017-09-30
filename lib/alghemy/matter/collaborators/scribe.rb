require_relative 'tomes'

# Return Arrays as appropriate Tomes
module Scribe
  # Factory method, returns Tome
  def self.transcribe( list, dims = nil )
    dims ||= tomes[:mono].scribe(list).dims
    tome   = tome_class dims
    tome.scribe(list, dims)
  end

  # Define appropriate Tome
  def self.tome_class( dims )
    dims.nil? ? tomes[:mono] : tomes[:poly]
  end

  # Tome subclasses
  def self.tomes
    {mono: Grimoire, poly: Metamoire}
  end
end
