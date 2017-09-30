# Memory recording module for transmutations
module Memrec
  def memrec( mems )
    memrec = cata.fetch(:memrec, true)
    return {} unless memrec
    if memrec == true
      memrec = m_cat.merge [cata.assoc(:extype)].to_h
      memrec = [[cata[:tran], memrec]]
      memrec += mems if mems
    end
    {mems: memrec}
  end

  private

  # exclude superfluous information
  def m_cat
    rejects = def_rejects
    cata.reject {|k| k[/^(#{rejects})/] }
  end

  def def_rejects
    assumed = defaults.keys.select do |asp|
      cata[asp] == defaults[asp]
    end
    (rejects + assumed) * '|'
  end

  def rejects
    %w[enum ext glob label memrec raw solution tome tran type]
  end

  def defaults
    self.class.defaults
  end
end
