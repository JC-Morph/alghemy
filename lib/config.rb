# frozen_string_literal: true

# Public: Define configurable constants and variables used in Alghemy.
module Alghemy
  class << self
    attr_accessor *%i[
      ear_sleep
      encoding
      bitdepth
      ladspath
      leave_no_trace
      overwrite
      verbose
      rubric_print
      rubric_colour
      show_input
    ]
  end

  # ---- CONSTANTS ----
  #
  # Root directory for transmuted Matter.
  ROOT = 'Alghemy'
  # File separator shortcut.
  SEP = File::SEPARATOR

  # ---- PATHS ----
  #
  # NOTE: Not OS agnostic.
  # Public: Default path for LADSPA plugins when LADSPA_PATH is undefined.
  def self.default_path_ladspa
    File.join(*%w[/usr lib ladspa])
  end
  # Array of directories to search for LADSPA plugins.
  @ladspath = `echo $LADSPA_PATH`.strip.split(':')
  @ladspath = default_path_ladspa if ladspath.empty?

  # ---- TRANSMUTING ----
  #
  # Sleep duration for Listen gem used by Comrade::Scout.
  @ear_sleep = 0.1
  # Delete interstitial Matter after transmuting?
  @leave_no_trace = false
  # Automatically overwrite existing Matter?
  @overwrite = true

  # Default encoding conversion for sox sonification.
  @encoding = %w[unsigned float]
  # Default bitdepth conversion for sox sonification.
  @bitdepth = [8, 32]

  # ---- PRINTING ----
  #
  # Print all external processes before they're executed?
  @verbose = false
  # Print Transmutations before they're executed?
  @rubric_print = true
  # Colour the printed Transmutations?
  @rubric_colour = true
  # Show the input path when printing?
  @show_input = true

  # ---- TABLES ----
  #
  # Revertable Transmutations.
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
