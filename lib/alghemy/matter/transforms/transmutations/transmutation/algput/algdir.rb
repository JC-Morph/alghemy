# Public: Directory class for alghemical processes.
class Algdir < String
  # Public: Prepend and create directory.
  def self.open( dir )
    dir = File.join(LEADR, dir.to_s) unless dir.to_s[/^#{LEADR}/]
    FileUtils.makedirs dir
    new dir
  end

  # Public: Files in dir.
  def total
    Dir.glob(File.join(self, '*.*'))
  end

  private

  def matching( ext )
    total.select {|lmnt| File.extname(lmnt) == ext }
  end
end
