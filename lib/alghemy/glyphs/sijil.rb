require 'alghemy/factories'
require 'alghemy/modules'

module Alghemy
  module Glyphs
    # Public: Represents a path referencing the location of Matter.
    class Sijil < String
      include Modules[:trail]

      def self.compose( sijil )
        sij = new sijil
        sij.list.empty? ? match_error(sij) : sij
      end

      def self.match_error( sijil )
        raise IOError, "Cannot find any files matching: #{sijil}"
      end

      def list
        Dir.glob self
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

      def base_num
        base[/(?<=[_-])\d+$/]
      end

      def unglob
        gsub(/[_-]*(?<!\\)[\*\?]+/, '')
      end

      # TODO: Move.
      def ffglob
        glob = "_%0#{first.base_num.size}d"
        swap_parts base: unglob.base.concat(glob)
      end
    end
  end
end
