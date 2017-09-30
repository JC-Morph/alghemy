require_relative 'mute_get'
# Require Transposition classes
TRANSPOSITIONS.each do |transposition|
  require_relative File.join('transmutations', transposition)
end

# Transpose method module
module Transposable
  include MuteGet

  def transpose( lyst = {} )
    transposition = mute_get __callee__
    transposition.new(self, lyst).implement
  end
  # Define method calls
  TRANSPOSITIONS.each do |transposition|
    alias_method transposition, :transpose
  end

  # Reversion methods index
  def revertran( tran )
    REVERTABLE[tran]
  end
end
