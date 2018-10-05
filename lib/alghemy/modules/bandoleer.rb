require 'canister'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Bandoleer. Container used to retrieve dependencies. Contains vials
    # representing various objects. Bandoleers are expected to be available for
    # top-level namespaces in Alghemy.
    module Bandoleer
      include Methods[:retrieve]

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
        bandoleer[vial]
      end

      def equip( elixirs )
        elixirs.each do |vial, contents|
          bandoleer.register(vial) do
            retrieve vial
            contents
          end
        end
      end

      def equip_constants( vials )
        vials.each do |vial|
          bandoleer.register(vial) do
            retrieve vial
            const_get vial.capitalize
          end
        end
      end
    end
  end
end
