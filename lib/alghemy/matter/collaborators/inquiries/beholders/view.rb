require_relative '../inquire'

module View
  class << self
    include Inquire

    def windows_process?
      true
    end

    def moniker
      ['xnview']
    end

    def sub_process
      input << redirect
    end

    def redirect
      '1>&2'
    end
  end
end
