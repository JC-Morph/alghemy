module Paramtest

  def paramtest( sound, div = 10 )
    tot = 1.0 / div
    dir = File.join(File.dirname(sound), 'paramtest', sijil)
    FileUtils.makedirs dir
    params.each.with_index do |param, i|
      pre = format param.keys.first
      pre = "%03d_#{pre}" % i
      pre = File.join(dir, pre)
      div.times do |d|
        out   = pre + ('_%03d.' % d.succ)
        param = "--parameter #{i},#{tot * d.succ}"
        `mrswatson -i #{sound} -p #{sijil} #{param} -o "#{out}wav"`
        `sox -D "#{out}wav" -t raw -e un -b 8 "#{out}rgb"`
        `convert -size 936x698 -depth 8 "#{out}rgb" "#{out}png"`
        File.delete(out + 'rgb', out + 'wav')
      end
    end
  end

  def presetest( sound )
    dir = File.join(File.dirname(sound), 'presetest', sijil)
    FileUtils.makedirs dir
    presets.each.with_index do |preset, i|
      out = format preset
      out = "%03d_#{out}." % i
      out = File.join(dir, out)
      `mrswatson -i #{sound} -p #{sijil},#{i} -o "#{out}wav"`
      `sox -D "#{out}wav" -t raw -e un -b 8 "#{out}rgb"`
      `convert -size 936x698 -depth 8 "#{out}rgb" "#{out}png"`
      File.delete(out + 'rgb', out + 'wav')
    end
  end

  private

  # Private: Formats parameter or preset name to make it a legal filename.
  def format( name )
    name = name.gsub(/[<>\.\?]/, '')
    name = name.gsub(/[\/\s]/, '_')
  end
end
