module Alghemy
  # Public: Switch with a variable prefix; typically '-' or '+'. For example,
  # -append or +append for the Image Magick utility.
  class OpSwitch < Switch
    attr_accessor :op

    def sub_build( hsh )
      @op = ->(cata) { cata[hsh[:key]] ? '+' : '-' }
    end

    def structure( val )
      [op, label, val]
    end
  end
end
