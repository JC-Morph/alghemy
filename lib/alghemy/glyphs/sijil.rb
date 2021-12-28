require 'forwardable'
require 'alghemy/factories'
require 'alghemy/methods'
require 'alghemy/modules'

module Alghemy
  module Glyphs
    # Public: Represents a path referencing the location of Matter.
    class Sijil
      extend Forwardable
      include Methods[:deepclone]
      include Methods[:store]
      include Modules[:trail]
      def_delegators :@sijil, :[]=, :gsub, :inspect, :slice, :sub

      def self.compose( sijil )
        match_error(sijil) if list(sijil).empty?
        new sijil
      end

      def self.list( sijil )
        Dir.glob sijil.to_s
      end

      def self.match_error( sijil )
        raise IOError, "Cannot find any files matching: #{sijil.to_s}"
      end

      def initialize( filename )
        @sijil = filename.to_s
      end

      def to_s
        deepclone @sijil
      end

      def list
        self.class.list @sijil
      end

      def plural?
        list.size > 1
      end

      # Public: Delete any files Sijil represents after the number of files has
      # reached size #to_size.
      # def limit( to_size )
      #   return unless list.size > to_size
      #   list[to_size..-1].each {|lmnt| File.delete lmnt }
      # end

      # Public: Instantiate Matter from the current Sijil.
      #
      # Returns Matter.
      def evoke( memory = nil, record = true )
        store(memory) if memory && record
        Factories[:evoker].call(self.class, self)
      end
    end
  end
end
