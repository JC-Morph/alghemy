require 'alghemy/glyphs'
require 'alghemy/rubrics'

module Alghemy
  # Public: Sox related methods for Transmutations.
  module Boots

    def self.priorities
      [:ents, :ext]
    end

    def self.expects
      with_plurals :Sound
    end

    def rubric
      Rubrics[:sox]
    end

    def aural?
      !(lmnt.class.name =~ /Sounds*$/).nil?
    end

    private

    def sub_init
      stuff[:ents] = Glyphs[:ent].call stuff[:ents]
      tran_init
    end
  end
end
