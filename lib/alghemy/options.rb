# Public: Add constants for objects involved with Alghemy.
module Alghemy
  class << self
    attr_accessor :ear_sleep, :ladspath, :overwrite, :print_rubric, :verbose
  end

  # NOTE: Needs work to be made OS agnostic.
  # Public: Default path to search for ladspa plugins when LADSPA_PATH is
  # undefined.
  def self.default_path_ladspa
    File.join(*%w[/usr lib ladspa])
  end

  # Public: Sleep duration for Listen gem in Ear.
  @ear_sleep = 0.1
  # Public: Array of directories to search for LADSPA plugins.
  @ladspath = `echo $LADSPA_PATH`.strip.split(':')
  @ladspath = default_path_ladspa if ladspath.empty?
  # Public: Boolean for overwriting existing files.
  @overwrite = true
  # Public: Boolean for printing transmutations before they're executed.
  @print_rubric = true
  # Public: Boolean for printing all external processes before they're executed.
  @verbose = false

  # Public: Root directory for transmuted Matter.
  LEADR = 'Alghemy'.freeze

  # Public: Shortcut for file separator.
  SEP = File::SEPARATOR

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
