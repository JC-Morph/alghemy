require_relative 'rubric/memrec'
require_relative 'rubric/process'

# Encapsulates behaviour for all Rubrics
class Rubric
  include Memrec
  attr_reader :cata

  def self.defaults
    {}
  end

  def initialize( cata )
    @cata = self.class.defaults.merge cata
  end

  def intone( io )
    Process.run(process, io)
  end

  private

  def process
    moniker + send(cata[:tran])
  end

  def moniker
    raise NotImplementedError
  end

  def input
    '%{input}'
  end

  def output
    '%{output}'
  end
end
