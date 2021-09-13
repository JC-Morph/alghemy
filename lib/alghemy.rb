# Extend $LOAD_PATH until gem release.
dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir || File.expand_path(dir))

require 'config'
require 'version'
require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/comrades'
require 'alghemy/glyphs'
require 'alghemy/properties'

include Alghemy
include Affinities
include Glyphs
include Properties

Hunter = Comrades[:hunter]
Matter = Ancestors[:matter]
