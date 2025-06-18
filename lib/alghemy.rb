# Extend $LOAD_PATH until gem release.
dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir || File.expand_path(dir))
# Tweak wine verbosity to make mrswatson cleaner in Linux
ENV['WINEDEBUG'] = 'fixme-all'

require 'config'
# require 'alghemy/version'
require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/comrades'
require 'alghemy/glyphs'
require 'alghemy/mutagens'
require 'alghemy/tomes'
require 'alghemy/vamp_clans'

include Alghemy
include Affinities
include Glyphs
include Tomes
include VampClans

Hunter = Comrades[:hunter]
Matter = Ancestors[:matter]

Ladspa = Mutagens[:ladspa]
Vst    = Mutagens[:vst]
