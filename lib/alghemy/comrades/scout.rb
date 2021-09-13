require 'alghemy/methods'
require 'listen'

module Alghemy
  module Comrades
    # Public: Listen gem wrapper for watching directories.
    module Scout
      class << self
        include Methods[:alget]
        attr_reader :spotted, :monitoring

        def pwd
          @pwd ||= Pathname.new Dir.pwd
        end

        # Public: Start monitoring dir for modified or added files.
        def monitor( dir = Dir.pwd )
          @spotted = []
          @monitoring = Listen.to(dir) do |modified, added|
            spotted << modified << added
          end
          monitoring.start
          sleep ear_sleep
        end

        # Public: Stop monitoring and return Array of heard files.
        def report
          sleep ear_sleep
          monitoring.stop
          Listen.stop
          spotted.flatten.uniq.collect {|file| relate file }
        end

        private

        # Internal: Defines number of seconds to sleep before and after
        # processing files, to allow for them to be heard correctly. Increase
        # value in alghemy/options.rb if you have problems regarding this.
        def ear_sleep
          default = 0.1
          alget(:ear_sleep) || default
        end

        # Internal: Return file path relative to the working directory.
        def relate( file )
          file     = Pathname.new file
          relative = file.relative_path_from pwd
          relative.to_s
        end
      end
    end
  end
end
