require 'canister'
require 'alghemy/options'

module Alghemy
  # Public: Bandoleer. Vials contain modules containing a single method.
  module Methods
    def self.bandoleer
      @bandoleer ||= Canister.new
    end

    def self.[]( key )
      bandoleer[key]
    end

    dir   = name.sub('::', SEP).downcase
    vials = %w[alget array_merge deepclone hshprint retrieve transmute]

    vials.each do |vial|
      const = vial.split('_').map(&:capitalize).join.to_sym

      bandoleer.register vial do
        require File.join(dir, vial) unless const_defined?(const)
        const_get const
      end
    end
  end
end
