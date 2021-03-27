require 'canister'
require 'alghemy/options'

module Alghemy
  # Public: Bandoleer. Container used to retrieve dependencies. Contains vials
  # representing various objects. Bandoleers are expected to be available for
  # top-level namespaces in Alghemy.
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
      vials.each do |vial|
        bandoleer.register(vial) do
          retrieve vial
          const_get desnake(vial.to_s)
        end
      end
    end

    private

    # Internal: 'Requires' the specified files, adding them to the current
    # context. Ignores the input if it matches an already defined constant.
    def retrieve( files )
      [files].flatten.each do |file|
        file = file.to_s
        next if const_defined? desnake(file)
        require File.join(name.sub('::', SEP).downcase, file)
      end
    end

    # Internal: Converts String from snake_case to ClassCase.
    def desnake( str )
      str.split('_').map(&:capitalize).join
    end
  end
end
