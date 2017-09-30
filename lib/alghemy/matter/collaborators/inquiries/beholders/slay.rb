require_relative '../inquire'

module Slay
  class << self
    include Inquire

    def moniker
      ['sox']
    end

    def sub_process
      input << wave_type
    end

    def wave_type
      %w[-t waveaudio]
    end
  end
end
