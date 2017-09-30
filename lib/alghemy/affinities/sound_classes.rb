require_relative 'ancestors'
require_relative 'constants/sound_constants'

# Public: Represents a sound.
class Sound < Element
  extend SoundConstants
end

# Public: Represents multiple sounds.
class Sounds < Elements
  extend SoundConstants
end
