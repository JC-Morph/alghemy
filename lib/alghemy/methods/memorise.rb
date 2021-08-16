require 'alghemy/glyphs'

module Alghemy
  module Methods
    # Public: Memory recording module.
    module Memorise
      # Public: Returns Hash of options necessary to identify or revert a
      # transform, along with prior mems from the transmutation input.
      #
      # memory - Hash of options to keep from transform.
      def memorise( memory, stuff )
        record = stuff.fetch(:record, true)
        return unless memory && record
        record = [Glyphs[:memory].new(memory)]
        binding.pry
        Glyphs[:archive].store(self.to_s, record)
      end
    end
  end
end
