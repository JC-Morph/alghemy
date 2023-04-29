require 'canister'

module Alghemy
  # Public: Bandoleer. Container used to retrieve dependencies.
  # Contains vials representing various objects.
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

    def equip( elixirs )
      elixirs.each do |vial, contents|
        bandoleer.register(vial.downcase) do
          retrieve vial
          contents
        end
      end
    end

    def equip_constants( vials )
      [vials].flatten.each do |vial|
        bandoleer.register(vial) do
          retrieve vial
          const_get to_camel(vial.to_s)
        end
      end
    end

    private

    # Internal: 'Requires' the specified files, adding them to the current
    # context. Ignores the input if it matches an already defined constant.
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
