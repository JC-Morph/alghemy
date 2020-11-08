# Public: Memory recording module for transmutations.
module MemRec
  # Public: Returns Hash of options necessary to identify or revert a transform,
  # along with prior mems from the transmutation input.
  #
  # mems  - Prior memories from input to transmutation. Expected to be Array in
  #         the same format as mems created by memrec.
  # m_cat - Hash of options to keep from transform.
  def record_memory( old_mems, new_mems )
    record = cata.fetch(:memrec, true)
    return {} unless record
    if record == true
      record = [[cata[:tran], new_mems]]
      record += old_mems if old_mems
    end
    {mems: record || old_mems}
  end

  # Public: Expects cata to be supplied by transmutation class. Currently
  # Rubrics are expected, but this may change.
  def cata
    raise NotImplementedError
  end
end
