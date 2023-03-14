require 'alghemy/comrades'

# Public: Extract information from VST plugins using mrswatson utility.
module VstInfo
  def params
    data = find 'Parameters'
    data.collect {|line| {line[regx.name].to_s => line[regx.dflt]} }
  end

  def presets
    data = find 'Programs'
    data.collect {|line| line[regx.name].to_s }
  end

  def info
    process = "mrswatson -p #{sijil} --display-info 2>&1"
    Comrades[:invoker].cast(process).split("\n")
  end

  def sijil
    raise NotImplementedError
  end

  private

  def find( target )
    hook = /#{target}(?= \(.+\):)/
    line = info.index {|v| v[hook] }
    size = info[line][regx.size]
    info[line.succ..(line + size.to_i)]
  end

  # Private: Regular expressions used for parsing and formatting Vst data.
  Regx = Struct.new(:size, :name, :dflt)
  def regx
    Regx.new(
      /(?<=\()\d+(?= \w+\):)/,
      /(?<=').+(?=')/,
      /(?<=\()-?\d\.\d+(?=\))/
    )
  end
end
