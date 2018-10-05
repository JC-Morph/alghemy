# Public: Add constants for objects involved with Alghemy.
module Alghemy
  class << self
    attr_accessor :overwrite, :print_rubric, :ear_sleep
  end

  # Public: Boolean for overwriting existing files.
  @overwrite    = true
  # Public: Boolean for printing external processes before they're executed.
  @print_rubric = true
  # Public: Sleep duration for Listen gem in Ear.
  @ear_sleep    = 0.1

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
