require 'ostruct'
require_relative 'transmutation/algput'
require_relative 'transmutation/rubrics'

# Internal: Base class for processes that change Matter in some way, creating
# one or more new files and returning new Matter.
class Transmutation
  attr_reader :lmnt, :cata

  # Internal: Initialise a Transmutant.
  #
  # lmnt - The Matter to build the transform for.  Expected to comprise part of
  #        the input for the transform.
  # lyst - Hash of initialisation options (default: {}).
  def initialize( lmnt, lyst = {} )
    @lmnt = lmnt
    @cata = lyst.dup
    @solution = lmnt.class
    @tome     = lmnt.list
    sub_init
    @cata =fin_cata
  end

  # Internal: Initialises Algput to define output environment, then Rubric to
  # define the process String. Invoke Tome with Algput & Rubric to create new
  # files, then evoke new instance of Matter.
  #
  # Returns new instance of Matter.
  def implement
    algput = Algput.new cata.merge(put_lyst)
    rubric = rubriclass.new cata.merge(raw: lmnt.raw?)
    heard  = @tome.invoke(algput, rubric)
    evoke(list(heard), rubric)
  end

  # Internal: Returns Rubric for current transmutation.
  def rubriclass
    clss = cata[:type] || lmnt.class
    clss.tools.rubric
  end

  # Internal: Returns a Tome of all files in Array.
  #
  # arr - Array containing Strings of filenames.
  def list( arr )
    Scribe.transcribe arr
  end

  # Internal: Evoke new Matter from Tome with memories from Rubric.
  #
  # tome   - Tome of filenames that were heard during transmutation.
  # rubric - Rubric used for transmutation; memrec i.e. memory-recording duck.
  #
  # Returns new instance of Matter.
  def evoke( tome, rubric )
    sijil = tome.size < 2 ? tome.first : tome.globvert
    sijil.limit tome.size
    sijil.evoke rubric.memrec(lmnt.mems)
  end

  private

  # Internal: Duckable initialisation.
  def sub_init
    @cata = defaults.merge cata
    tran_init
  end

  # Internal: Returns Hash of default values for @cata that can be overridden.
  def defaults
    {ext: lmnt.sijil.ext}
  end

  # Internal: Second-tier duckable initialisation.
  # TODO: Assimilate with sub_init.
  def tran_init
    raise NotImplementedError
  end

  # Internal: Finish defining Hash cata.
  def fin_cata
    prepext
    extype = [lmnt.sijil.ext, lmnt.class]
    tran   = self.class.to_s.downcase.to_sym
    cata.merge extype: extype, tran: tran
  end

  # Internal: Prepend extension with period if not already present.
  def prepext
    cata[:ext].prepend('.') if cata[:ext][/^[^\.]/]
  end

  # Internal: Returns Hash with variables specific to Algput initialisation.
  def put_lyst
    {sijil: lmnt.sijil, plural: plural?}
  end

  # Internal: Asks if expected output Class ends with an 's'. Denotes whether
  # output is expected to consist of more than one file.
  #
  # Returns boolean.
  def plural?
    !(@solution.to_s =~ /s$/).nil?
  end
end
