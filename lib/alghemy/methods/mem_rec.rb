module Alghemy
  module Methods
    # Public: Memory recording module for use by an Alghemist.
    module MemRec
      # Public: Returns Hash of options necessary to identify or revert a
      # transform, along with prior mems from the transmutation input.
      #
      # old_mems - Prior memories from input to transmutation. Expected to be an
      #            Array in the same format as mems created by mem_rec.
      # new_mems - Hash of options to keep from transform.
      def mem_rec( cata, old_mems, new_mems )
        record = cata.fetch(:mem_rec, true)
        return {} unless record
        if record == true
          record = [[cata[:tran], new_mems]]
          record += old_mems if old_mems
        end
        {mems: record || old_mems}
      end
    end
  end
end
