require 'ostruct'
require 'alghemy/modules'

module Alghemy
  module Modules
    # Public: Include module. Aspect functionality and lookup. Aspects are
    # attributes of Files that can be found using external utilities, like
    # image or video size, video or sound duration, etc.
    module Aspects
      # Internal: Extends class with Clasps Module.
      #
      # base - Class that included self.
      def self.included( base )
        base.extend Modules[:aspect_finder]
      end

      # Public: Aspect finder, updates Hash of aspects.
      #
      # asp - String naming the aspect to calculate. Should be included in
      #       #aspects.
      #
      # Returns individual aspect if specified. If no aspect is specified,
      # returns a Hash of all the aspects that have been calculated.
      def find( aspect = nil )
        @asps ||= {}
        return @asps unless aspect
        return @asps[aspect] if @asps[aspect]
        @asps[aspect] = perceive aspect
      end

      # Public: Duck for aspect retrieval method.
      def perceive( _aspect )
        raise NotImplementedError
      end

      # Public: Returns boolean if class has no aspects defined.
      def raw?
        self.class.aspects.empty?
      end
    end
  end
end
