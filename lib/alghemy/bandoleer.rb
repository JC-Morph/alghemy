require 'canister'

module Alghemy
  # Public: Wrapper for Canister, a container gem used to register dependencies.
  # Provides helper methods for referencing constants from files.
  module Bandoleer
    def self.extended( base )
      base.define_singleton_method :included do |_base|
        equipped.each {|vial| bandoleer.resolve vial }
      end
    end

    def equipped
      bandoleer.keys
    end

    def bandoleer
      @bandoleer ||= Canister.new
    end

    def []( vial )
      bandoleer[vial.downcase]
    end

    def equip( vials )
      [vials].flatten.each do |vial|
        bandoleer.register(vial) do
          retrieve vial
          const_get to_camel(vial.to_s)
        end
      end
    end

    def equip_custom( elixirs )
      elixirs.each do |vial, contents|
        bandoleer.register(vial.downcase) do
          retrieve vial
          contents
        end
      end
    end

    private

    # Internal: Explicitly requires given files, allowing Bandoleer to reference
    # any defined constants in the current context. Skips input if it directly
    # matches an already defined constant.
    def retrieve( files )
      [files].flatten.each do |file|
        file = file.to_s
        next if const_defined? to_camel(file)
        require File.join(name.sub('::', File::SEPARATOR).downcase, file)
      end
    end

    # Internal: Converts String from snake_case to CamelCase.
    def to_camel( str )
      str.split('_').map(&:capitalize).join
    end
  end
end
