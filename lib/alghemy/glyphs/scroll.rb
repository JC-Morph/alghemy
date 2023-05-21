require 'forwardable'
require 'paint'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Defines an Array to be invoked on the command-line. Can be used
    # to build a process piece-by-piece using #<<. Use the #condense method to
    # resolve Procs and perform String substitutions.
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

      def palimpsest
        @scroll = [scroll[0]]
        @fancy  = [fancy[0]]
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
        spell = Hash.new {|hsh, key| hsh[key] = [] }
        scroll.each_with_index do |passage, idx|
          passage = translate_passage(passage, io)
          spell[:raw]   << passage
          spell[:fancy] << format(fancy[idx], {content: passage})
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

      def translate_passage( passage, io )
        [passage].flatten.map do |word|
          word.is_a?(Proc) ? word.call(io) : format(word.to_s, io)
        end.join(' ')
      end
    end
  end
end
