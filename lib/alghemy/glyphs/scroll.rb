require 'forwardable'
require 'paint'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Defines an Array to be invoked on the command-line. Can be used
    # to build a process piece-by-piece using #<<, and can use the #condense
    # method to resolve any Procs, and substitute any Strings.
    class Scroll
      extend Forwardable
      include Methods[:alget]
      def_delegators :scroll, :map
      attr_reader    :scroll, :fancy

      def pretty_print( pp )
        pp.pp(scroll)
      end

      def initialize( moniker = '' )
        @scroll = [moniker]
        @fancy  = [paint(:moniker, moniker)]
      end

      def read
        text = alget(:rubric_colour) ? fancy : scroll
        text * ' '
      end

      def <<( passage )
        return lookup(passage) if passage.is_a?(Hash)
        scroll << passage
        fancy  << paint
      end

      def lookup( passage )
        passage.each do |key, value|
          scroll << value
          fancy  << paint(key)
        end
      end

      def condense( io = {} )
        spell = Hash.new {|k, v| k[v] = [] }
        scroll.each.with_index do |passage, i|
          passage = [passage].flatten.map do |word|
            word.is_a?(Proc) ?
              word.call(io) :
              word.to_s % io
          end.join(' ')
          spell[:raw]   << passage
          spell[:fancy] << fancy[i] % {content: passage}
        end
        spell
      end

      private

      def paint( key = nil, string = nil )
        string ||= '{matter}' if key == :input && !alget(:show_input)
        string ||= '%{content}'
        return string unless key
        Paint[string, *cipher[key].flatten]
      end

      def cipher
        {
          moniker: ['tomato', :bold],
          input:   ['lime green'],
          output:  ['lime green', :bold]
        }
      end
    end
  end
end
