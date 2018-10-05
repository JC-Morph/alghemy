require 'canister'
require 'alghemy/methods'

module Alghemy
  # Public: Bandoleer. Vials contain modules expected to be used to extend other
  # objects.
  module Modules
    extend Methods[:retrieve]

    def self.bandoleer
      @bandoleer ||= Canister.new
    end

    def self.[]( key )
      bandoleer[key]
    end

    vials = %i[affinitester
               analyse
               aspects
               bandoleer
               clasps
               laws
               osman
               plural
               request
               serial_recall
               switcher
               trail]

    vials.each do |vial|
      const = vial.capitalize
      unless (vial.to_s =~ /_/).nil?
        const = vial.to_s.split('_').map(&:capitalize).join.to_sym
      end
      bandoleer.register(vial) do
        retrieve vial
        const_get const
      end
    end
  end
end
