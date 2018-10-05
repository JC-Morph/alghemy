# Extend $LOAD_PATH until gem release.
dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir || File.expand_path(dir))

require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/version'

include Alghemy
include Affinities

Matter = Ancestors[:matter]
