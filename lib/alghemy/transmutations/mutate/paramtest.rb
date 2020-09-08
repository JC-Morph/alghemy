module Paramtest

  def paramtest( sound, div = 10 )
    tot = 1.0 / div
    dir = File.join(File.dirname(sound), 'paramtest', sijil)
    FileUtils.makedirs dir
    params.each.with_index do |p, i|
      out = ('%03d' % i) + "_#{p.keys.first.sub('/', '_')}"
      out = File.join(dir, out)
      div.times do |d|
        pout = out + ('_%03d.' % d.succ)
        `mrswatson -i #{sound} -p #{sijil} --parameter #{i},#{tot * d.succ} -o "#{pout}wav"`
        `sox -D "#{pout}wav" -t raw -e un -b 8 "#{pout}rgb"`
        `convert -size 936x698 -depth 8 "#{pout}rgb" "#{pout}png"`
        File.delete(pout + 'rgb', pout + 'wav')
      end
    end
  end

  def presetest( sound )
    dir = File.join(File.dirname(sound), 'presetest', sijil)
    FileUtils.makedirs dir
    presets.each.with_index do |p, i|
      out = "%03d_#{p.gsub(/[<>\.\?]/, '')}." % i
      out = File.join(dir, out)
      `mrswatson -i #{sound} -p #{sijil},#{i} -o "#{out}wav"`
      `sox -D "#{out}wav" -t raw -e un -b 8 "#{out}rgb"`
      `convert -size 936x698 -depth 8 "#{out}rgb" "#{out}png"`
      File.delete(out + 'rgb', out + 'wav')
    end
  end
end
