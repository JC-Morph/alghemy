require 'forwardable'
require 'alghemy/factories'
require 'alghemy/modules'

module Alghemy
  module Glyphs
    # Public: Represents a path referencing the location of Matter.
    class Sijil
      extend Forwardable
      def_delegators :@sijil, :[]=, :gsub, :inspect, :slice, :sub, :to_s
      include Modules[:trail]

      def self.compose( sijil )
        sij = new sijil
        sij.list.empty? ? match_error(sij) : sij
      end

      def self.match_error( sijil )
        raise IOError, "Cannot find any files matching: #{sijil}"
      end

      def initialize( filename )
        @sijil = filename
      end

      def list
        Dir.glob self.to_s
      end

      # Public: Open Matter with default application.
      def behold
        spell = Gem.win_platform? ? first.fenestrate : "xdg-open #{first.to_s}"
        Apparatus[:invoker].engage "#{spell} 2>&1"
      end

      def first
        self.class.new list.send(__callee__)
      end
      alias last first

      def plural?
        list.size > 1
      end

      def limit( to_size )
        return unless list.size > to_size
        list[to_size..-1].each {|lmnt| File.delete lmnt }
      end

      def evoke( lyst = {} )
        Factories[:evoker].call(self.class, self, lyst)
      end

      def unglob
        self.class.new gsub(/[_-]*(?<!\\)[\*\?]+/, '')
      end
    end
  end
end
