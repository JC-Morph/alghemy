require 'alghemy/glyphs'
require 'alghemy/rubrics'

module Alghemy
  # Public: Sox related methods for Transmutations.
  module Foot
    def rubric
      Rubrics[:sock]
    end

    def sub_init
      cata[:ents] = Glyphs[:ent].call cata[:ents]
      tran_init
    end

    def aural?
      !(lmnt.class.to_s =~ /Sounds*$/).nil?
    end
  end
end
