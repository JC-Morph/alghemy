require 'alghemy/factories'
require 'alghemy/mutagens'

module Alghemy
  module Metamutations
    module Paramtest
      def paramtest( vst, automation )
        tome = []
        vst  = Mutagens[:vst].new vst
        vst.params.keys.each do |param|
          tome << mutate(vst, param => automation, suffix: "_#{param}")
        end
        provoke tome
      end

      private

      def provoke( tome )
        mem  = tome.first.mems.list.last
        tome = tome.map {|lmnt| lmnt.list.entries }.flatten
        Factories[:scribe].call(tome).evoke(mem)
      end
    end
  end
end
