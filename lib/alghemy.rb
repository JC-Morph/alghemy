require_relative 'alghemy/version'

# Public: Encapsulates all functionality.
module Alghemy
  require_relative 'alghemy/affinities'
end

# Element.class GLOSSARY

# ACCESSIBLE ATTRIBUTES

# @sijil = the abstracted digital location of your element ( "path/file.ext" )

# Properties
# All elements have properties.
# The innate properties are different for each type of element.

# ---
# Image and Video
# @space = spacial dimension ( "horizontal x vertical" )

# ---
# Video and Sound
# @time = temporal dimension ( duration )

# Because Video and Sound elements are perceivable in the temporal dimension,
#  they necessarily possess two other related properties:

# @frequency = rate ( Video.( framerate ) || Sound.( samplerate ) )
# @lifespan  = total ( Video.( frames )    || Sound.( samples ) )

# ---
# Sound and Image
# @depth = bit depth ( depth )

# ---
# All Elements
# @arcana = ( Video.( pixel_format ) || Sound.( encoding ) || Image.( colorspace )

# @mems = an Array retaining information of all non-mutagenic transmutations
#  undertaken between an Element's initial and current states.
