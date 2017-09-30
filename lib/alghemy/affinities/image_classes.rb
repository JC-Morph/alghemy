require_relative 'ancestors'
require_relative 'constants/image_constants'

# Public: Represents an image.
class Image < Element
  extend ImageConstants
end

# Public: Represents multiple images.
class Images < Elements
  extend ImageConstants
end
