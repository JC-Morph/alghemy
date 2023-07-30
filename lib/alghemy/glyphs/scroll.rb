require 'forwardable'
require 'paint'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Defines an Array to be invoked on the command-line. Can be used
    # to build a process piece-by-piece using #<<. Use the #interpret method to
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

      def read( hsh = {raw: scroll, fancy: fancy} )
        fmt = alget(:rubric_colour) ? :fancy : :raw
        hsh[fmt] * ' '
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

      def interpret( io = {} )
        spell = Hash.new {|hsh, key| hsh[key] = [] }
        scroll.each_with_index do |passage, idx|
          passage = translate_passage(passage, io)
          spell[:raw]   << passage
          spell[:fancy] << format(fancy[idx], {content: passage})
        end
        puts read(spell) if alget(:rubric_print)
        spell[:raw]
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
