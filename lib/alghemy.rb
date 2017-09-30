require_relative 'alghemy/version'

# Public: Encapsulates all functionality.
module Alghemy
  require_relative 'alghemy/affinities'
end

# Matter GLOSSARY
#
# Aspects
# All elements have aspects.
# The innate aspects are different for each type of element.

# ---
# Image and Video
# space    = spacial dimension ("horizontal x vertical")

# ---
# Video and Sound
# time     = temporal dimension (Float)

# Because Video and Sound elements are perceivable in the temporal dimension,
#  they necessarily possess two other related properties:

# freq     = rate (Video:framerate || Sound:samplerate)
# lifespan = total   (Video:frames || Sound:samples)

# ---
# Sound and Image
# depth    = bitdepth (Integer)

# ---
# All Elements
# arcana   = (Video:pixel_format || Sound:encoding || Image:colorspace)

# @mems    = Array retaining information of all transmutations
#  undertaken between Matter's initial and current states.
