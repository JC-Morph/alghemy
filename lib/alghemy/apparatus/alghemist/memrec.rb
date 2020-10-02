# Public: Memory recording module for transmutations.
module Memrec
  # Public: Returns Hash of options necessary to identify or revert a transform,
  # along with prior mems from the transmutation input.
  #
  # mems  - Prior memories from input to transmutation. Expected to be Array in
  #         the same format as mems created by memrec.
  # m_cat - Hash of options to keep from transform.
  def memrec( mems, m_cat )
    memrec = cata.fetch(:memrec, true)
    return {} unless memrec
    if memrec == true
      memrec = [[cata[:tran], m_cat]]
      memrec += mems if mems
    end
    {mems: memrec || mems}
  end

  # Public: Expects cata to be supplied by transmutation class. Currently
  # Rubrics are expected, but this may change.
  def cata
    raise NotImplementedError
  end
end
