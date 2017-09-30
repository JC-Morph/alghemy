require_relative 'ents'

# Sox related methods for Transmutations
module Foot
  def rubriclass
    Sock
  end

  def sub_init
    cata[:ents] = Ents.invoke cata[:ents]
    tran_init
    cata[:ents].entcheck
  end

  def aural?
    !(lmnt.class.to_s =~ /^Sound/).nil?
  end
end
