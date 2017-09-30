# Constants for Matter-related objects.

# Public: Boolean for overwriting existing files.
$overwrite = true

# Public: Shortcut for file separator.
SEP   = File::SEPARATOR

# Public: Sleep duration for Listen gem in Ear.
EAR_SLEEP = 0.1

# Public: Root directory for transmuted Matter.
LEADR      = 'Alghemy'

# Public: List of revertable Transmutants.
TRANSPOSITIONS = %w[sonify visualise fft ift frames compile sublimate]
# Public: Table of Transmutant reversions.
REVERTABLE     = {
  sonify:    :visualise,
  visualise: :sonify,
  fft:       :ift,
  ift:       :fft,
  frames:    :compile,
  compile:   :frames,
  sublimate: :sublimate
}
