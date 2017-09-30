require_relative 'matter_includes'
require_relative 'matter/aspects'
require_relative 'matter/collaborators'

# Public: Base representation of transmutable files and group of files.
class Matter
  include MatterModules
  include Aspects
  attr_reader :sijil, :dims

  def self.tools
    AffTools.new View
  end

  # Public: Constructor. Attempts to discern what type of file sijil is, and
  # then initialise the appropriate subclass. This is the preferred
  # initialisation method for Matter.
  #
  # sijil - See #initialize.
  # lyst  - See #initialize.
  #
  # Returns new instance of Matter.
  def self.evoke( sijil, lyst = {} )
    clss = to_s.downcase.to_sym
    Evoke.send(clss, sijil, lyst)
  end

  # Internal: Initialise a Matter. Publicly, Matter should always be evoked.
  #
  # sijil - String representing a filename or glob pattern.
  # lyst  - Hash of initialisation options (default: {}):
  #         :mems - Memories of previous transforms (optional).
  def initialize( sijil, lyst = {} )
    @sijil = Sijil.compose sijil
    self.class.def_asps
    sub_init lyst
    mem_init lyst[:mems]
  end

  # Public: Returns Tome of all files in sijil.
  def list
    Scribe.transcribe(sijil.list, dims)
  end

  # Public: Calculate and print aspects.
  def identify
    clss = self.class
    puts "\nClass => #{clss}\nsijil => #{sijil}\n\n"
    clss.aspects.each {|asp| send asp }
    hshprint asps
  end

  # Public: Open Matter with designated executable.
  def behold
    self.class.tools.play.this sijil
  end

  # Public: Open Matter with default application.
  def open
    file = sijil.first
    file = file.fenestrate if Gem.win_platform?
    Process.execute "#{file} 2>&1"
  end

  private

  # Internal: Duckable initialisation, reserved for subclasses.
  def sub_init( _lyst )
    nil
  end

  # TODO: make analyse method with usable param?
  # Internal: Analyse Matter with designated executable.
  def perceive( asp )
    self.class.tools.analyse.this(sijil.first, asp)
  end
end
