require 'alghemy/glyphs'

module Alghemy
  module Modules
    # Public: Memory recording module.
    module Memorise
      # Public: Returns Hash of options necessary to identify or revert a
      # transform, along with prior mems from the transmutation input.
      #
      # old_mems - Prior memories from input to transmutation. Expected to be an
      #            Array in the same format as mems created by record_memory.
      # new_mems - Hash of options to keep from transform.
      def record_memory( stuff, old_mems, new_mems )
        record = stuff.fetch(:record, true)
        return {} unless record
        if record == true
          memory = {name: stuff[:name].to_sym, **new_mems}
          record = [Glyphs[:memory].new(memory)]
          record.unshift(*old_mems.list) if old_mems
        end
        {mems: record}
      end

      def store_memory( sijil, memory )
        Glyphs[:archive].store(sijil, memory)
      end
    end
  end
end
