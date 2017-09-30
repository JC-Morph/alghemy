require_relative 'ancestors'
require_relative 'constants/video_constants'

# Public: Represents a video.
class Video < Element
  extend VideoConstants
end

# Public: Represents multiple videos.
class Videos < Elements
  extend VideoConstants
end
