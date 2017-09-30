require_relative 'matter_constants'
require_relative 'matter/hshprint'
require_relative 'matter/serial_recall'
require_relative 'matter/transforms'

# All necessary inclusions for the Matter class.
module MatterModules
  # Hash print method.
  include Hshprint
  # Memory functions.
  include Recall
  # Transpose method and collaborators.
  include Transposable
  # Mutate method and collaborators.
  include Mutable
end
