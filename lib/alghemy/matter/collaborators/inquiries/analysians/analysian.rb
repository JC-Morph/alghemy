require_relative '../inquire'

# Public: Analyse a file with a tool.
module Analysian
  include Inquire
  attr_reader :asp, :cat, :fmt
  alias execute this

  def this( sijil, asp = nil )
    return report(sijil) unless asp
    @asp = asp
    @cat = catdex[asp] || asp
    @fmt = fmtdex[asp]
    result = execute(sijil).strip
    fmt ? format(result) : result
  end

  def report( sijil )
    Process.run([moniker, input, '2>&1'], input: sijil)
  end

  def process
    moniker << sub_process << input
  end

  private

  def catdex
    {}
  end
  alias fmtdex catdex

  def format( result )
    fmt.is_a?(Proc) ? fmt.call(result) : result.send(fmt)
  end
end
