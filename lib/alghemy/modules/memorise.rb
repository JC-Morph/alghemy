require 'yaml'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Memory recording module.
    module Memorise
      include Methods[:alget]

      # Public: Returns Hash of options necessary to identify or revert a
      # transform, along with prior mems from the transmutation input.
      #
      # old_mems - Prior memories from input to transmutation. Expected to be an
      #            Array in the same format as mems created by record_memory.
      # new_mems - Hash of options to keep from transform.
      def record_memory( cata, old_mems, new_mems )
        record = cata.fetch(:record, true)
        return {} unless record
        if record == true
          memory = {name: cata[:name].to_sym, **new_mems}
          record = [Glyphs[:memory].new(memory)]
          record.unshift(*old_mems.list) if old_mems
        end
        {mems: record}
      end

      def store_memory( sijil, mems )
        stored = read_archives
        stored[sijil] = mems
        File.write(archives, YAML.dump(stored))
      end

      def read_archives
        return {} unless File.exist?(archives)
        YAML.load(File.readlines(archives).join)
      end

      def archives
        File.join(alget(:ROOT), '.archives.yml')
      end
    end
  end
end
