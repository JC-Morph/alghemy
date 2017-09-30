require 'forwardable'
require_relative 'hshprint'
require_relative 'serial_recall/mems'

# Methods accessing stored Mems
module Recall
  extend Forwardable
  delegate :inherit => :mems
  include Hshprint
  attr_reader :mems

  def mem_init( mems )
    @mems = Mems.clonefreeze(mems) if mems
  end

  # Revert transforms on self using Mems
  def revert( levels = mems.size )
    mems.revert(self, levels)
  end

  # Prints Mems in a human-friendly format
  def memory
    mems.each.with_index do |mem, i|
      asps = {method: mem[0]}.merge mem[1]
      puts "\n\nTransform #{mems.size - i}"
      hshprint asps
    end
  end
end
