module Alghemy
  # Public: Directory class for alghemical processes.
  class Algdir < String
    # Public: Prepend and create directory.
    def self.open( dir )
      dir = dir.to_s
      dir = File.join(LEADR, dir) unless dir[/^#{LEADR}/]
      FileUtils.makedirs dir
      new dir
    end

    # Public: Returns Array of files in dir.
    def total
      Dir.glob(File.join(self, '*.*'))
    end

    private

    # Internal: Returns Array of files in dir with extension ext.
    def matching( ext )
      total.select {|lmnt| File.extname(lmnt) == ext }
    end
  end
end
