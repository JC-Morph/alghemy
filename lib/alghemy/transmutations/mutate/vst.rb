require_relative 'automation'
require_relative 'paramtest'

# Public: Represents a VST plugin.
class Vst
  include Paramtest
  attr_reader :sijil, :automatons

  def self.list
    name = /(?<=\\)[+\w][\w\.-]+.$/
    plugs.collect {|p| p[name] if p[/Vst/] }.compact
  end

  def self.plugs
    `mrswatson --list-plugins 2>&1`.split
  end

  def self.assert( plugin )
    return plugin if plugin.is_a? self
    new plugin
  end

  def initialize( plugin )
    @sijil = plugin
    match  = self.class.list.map(&:downcase).include? sijil.downcase
    match_error unless match
  end

  def info
    `mrswatson -p #{sijil} --display-info 2>&1`.split("\n")
  end

  def params
    data = find 'Parameters'
    data.collect {|line| {line[regx.name] => line[regx.dflt]} }
  end

  def presets
    data = find 'Programs'
    data.collect {|line| line[regx.name] }
  end

  def automate( lyst = {} )
    lyst = lyst.merge(total: params.size)
    @automatons = Automation.generate lyst
  end

  private

  def match_error
    msg = "Cannot find Vst with name: #{sijil}\nCheck Vst.list"
    raise IOError, msg
  end

  def find( target )
    hook = /#{target}(?= \(.+\):)/
    data = info
    data[scan(hook, data)]
  end

  def scan( hook, data )
    line = data.index {|v| v[hook] }
    size = data[line][regx.size]
    line.succ..(line + size.to_i)
  end

  def regx
    Regx.new(
      /(?<=\()\d+(?= \w+\):)/,
      /(?<=').+(?=')/,
      /(?<=\()-?\d\.\d+(?=\))/
    )
  end
  Regx = Struct.new(:size, :name, :dflt)
end
