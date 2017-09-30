require 'listen'

# Listen gem wrapper for watching directories
module Ear
  class << self
    attr_reader :pwd, :heard, :hearing

    # Start monitoring dir for modified or added files.
    def listen( dir = Dir.pwd )
      @pwd   = Pathname.new Dir.pwd
      @heard = []
      @hearing = Listen.to(dir) do |modified, added|
        heard << modified << added
      end
      hearing.start
      sleep EAR_SLEEP
    end

    # Stop monitoring and return Array of heard files.
    def amputate
      sleep EAR_SLEEP
      hearing.stop
      Listen.stop
      heard.flatten.uniq.collect {|file| relate file }
    end

    private

    # Return file path relative from working directory
    def relate( file )
      file     = Pathname.new file
      relative = file.relative_path_from pwd
      relative.to_s
    end
  end
end
