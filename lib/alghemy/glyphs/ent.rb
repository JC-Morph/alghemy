module Alghemy
  module Glyphs
    # Public: Representation of encoding and bitdepth variables for sox.
    class Ent < Array
      def self.invoke( ent = nil )
        ents = new [ent || ['unsigned', 8]].flatten(1)
        ents.balance
        ents
      end

      def enumerable_size
        select {|lmnt| lmnt.respond_to? :each }.size
      end

      # Public: Ensures self is two dimensional.
      def balance( ent = nil, act = :unshift )
        replace [flatten] if enumerable_size.zero?
        send(act, ent)    if ent && size == 1
        collect! {|ent_part| [ent_part].flatten } if size != enumerable_size
      end

      # Public: Ensures that bit is in a valid range for enc.
      def bitcheck
        encs = %w[(a|u-l) (un|s) f]
        bits = [8, 8, 32]
        each do |ent|
          enc = encs.index {|check| ent[0][/^#{check}/] }
          bit = bits[enc]
          chk = ent[1] && ent[1].to_i >= bit
          ent[1] = bit unless chk && enc != 0
        end
        self
      end

      def separate
        hsh = {}
        %i[enc bit].each.with_index do |ananym, i|
          hsh[ananym] = size == 1 ? first.slice(i) : collect {|ent| ent[i] }
        end
        hsh
      end
    end
  end
end
