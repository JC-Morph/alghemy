# Public: Add constants for objects involved with Alghemy.
module Alghemy
  class << self
    attr_accessor :ear_sleep, :overwrite, :print_rubric, :verbose
  end

  # Public: Sleep duration for Listen gem in Ear.
  @ear_sleep = 0.5
  # Public: Boolean for overwriting existing files.
  @overwrite = true
  # Public: Boolean for printing transmutations before they're executed.
  @print_rubric = true
  # Public: Boolean for printing all external processes before they're executed.
  @verbose = false

  # Public: Shortcut for file separator.
  SEP = File::SEPARATOR

  # Public: Root directory for transmuted Matter.
  LEADR = 'Alghemy'.freeze

  # Public: Table of Transmutant reversions.
  REVERTABLE = {
    sonify:    :visualise,
    visualise: :sonify,
    fft:       :ift,
    ift:       :fft,
    frames:    :compile,
    compile:   :frames,
    sublimate: :sublimate
  }.freeze
end
