require_relative '../matter'

# Public: Embodies multiple files.
class Elements < Matter
  extend Forwardable
  # Public: Returns first file in sijil.
  delegate :first => :sijil
  # Public: Slice shortcut for elements in list.
  delegate :[]    => :list

  # Public: Returns Integer of files represented by sijil.
  def size
    sijil.list.size
  end

  private

  # Internal: Check for grouped files during initialisation.
  def sub_init( lyst )
    dims  = lyst[:dims] || list.dims
    @dims = dims if dims && dims > 1
  end
end
