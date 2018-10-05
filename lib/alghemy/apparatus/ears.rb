require 'alghemy/methods'
require 'listen'

module Alghemy
  module Apparatus
    # Public: Listen gem wrapper for watching directories.
    module Ears
      class << self
        include Methods[:alget]
        attr_reader :heard, :hearing

        def pwd
          @pwd ||= Pathname.new Dir.pwd
        end

        # Public: Start monitoring dir for modified or added files.
        def listen( dir = Dir.pwd )
          @heard = []
          @hearing = Listen.to(dir) do |modified, added|
            heard << modified << added
          end
          hearing.start
          sleep ear_sleep
        end

        # Public: Stop monitoring and return Array of heard files.
        def amputate
          sleep ear_sleep
          hearing.stop
          Listen.stop
          heard.flatten.uniq.collect {|file| relate file }
        end

        private

        # Internal: Defines number of seconds to sleep before and after
        # processing files, to allow for them to be heard correctly. Increase
        # value in alghemy/options.rb if you have problems regarding this.
        def ear_sleep
          default = 0.1
          alget(:ear_sleep) || default
        end

        # Internal: Return file path relative from working directory.
        def relate( file )
          file     = Pathname.new file
          relative = file.relative_path_from pwd
          relative.to_s
        end
      end
    end
  end
end
