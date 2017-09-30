require_relative '../inquire'

module Fflay
  extend Inquire

  def self.moniker
    %w[ffplay -hide_banner]
  end
end
