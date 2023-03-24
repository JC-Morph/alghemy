# frozen_string_literal: true

# Public: Define configurable constants and variables used in Alghemy.
module Alghemy
  class << self
    attr_accessor \
      :ear_sleep,
      :ladspath,
      :leave_no_trace,
      :overwrite,
      :verbose,
      :rubric_print,
      :rubric_colour,
      :show_input
  end

  # Public: Sleep duration for Listen gem used by Comrade Scout.
  @ear_sleep = 0.1

  # NOTE: Not OS agnostic.
  # Public: Default path for ladspa plugins when LADSPA_PATH is undefined.
  def self.default_path_ladspa
    File.join(*%w[/usr lib ladspa])
  end
  # Public: Array of directories to search for LADSPA plugins.
  @ladspath = `echo $LADSPA_PATH`.strip.split(':')
  @ladspath = default_path_ladspa if ladspath.empty?

  # Public: Boolean for deleting interstitial Matter after transmuting.
  @leave_no_trace = false
  # Public: Boolean for overwriting existing files.
  @overwrite = true
  # Public: Boolean for printing all external processes before they're executed.
  @verbose   = false

  # Public: Boolean for printing transmutations before they're executed.
  @rubric_print  = true
  # Public: Boolean for colouring transmutation process strings.
  @rubric_colour = true
  # Public: Show the input path when printing Rubrics.
  @show_input = true

  # Public: Root directory for transmuted Matter.
  ROOT = 'Alghemy'
  # Public: Shortcut for file separator.
  SEP = File::SEPARATOR

  # Public: Table of Transmutant reversions.
  REVERTABLE = {
    sonify:    :visualise,
    visualise: :sonify,
    ffot:      :ifot,
    ifot:      :ffot,
    frames:    :compile,
    compile:   :frames,
    sublimate: :sublimate
  }.freeze
end
