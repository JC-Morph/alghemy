# Representation of encoding and bitdepth variables for sox
class Ents < Array
  def self.invoke( ent )
    new [ent || 'un'].flatten(1)
  end

  # balancing of two dimensional Arrays
  def balance( ent, act = :unshift )
    balance = [0, 1].select {|n| slice(n).respond_to?(:each) }
    case balance.size
    when 0
      replace [flatten].send( act, [ent].flatten )
    when 1
      collect {|prent| [prent].flatten }
    end
  end

  def entcheck
    encs = [/^(a|u)/, /^s/, /^f/]
    bits = [8, 16, 32]
    each do |ent|
      enc = encs.index {|check| ent[0][check] }
      bit = bits[enc]
      chk = ent[1] && ent[1] >= bit
      ent[1] = bit unless chk && enc != 0
    end
  end
end
